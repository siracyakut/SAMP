#include <a_samp>
#include <a_mysql>
#include <izcmd>
#include <foreach>
#include <sscanf2>

#define MAX_MESSAGE 			1024
#define SCM(%0,%1) 			SendClientMessage(%0,0x00B6E9FF,"[MSG] {FFFFFF}"%1)

enum
{
    DIALOG_MESSAGE,
    DIALOG_MESSAGE_READ,
    DIALOG_MESSAGE_SEND_1,
    DIALOG_MESSAGE_SEND_2
};

new MySQL: db;
enum msgVeri
{
	mID,
	mKullanici[24],
	mBaslik[35],
	mMesaj[1024],
	mOkunma
};
new mData[MAX_MESSAGE][msgVeri];
new Iterator: mesajlar<MAX_MESSAGE>;

public OnFilterScriptInit()
{
	new MySQLOpt: opt = mysql_init_options();
	mysql_set_option(opt, AUTO_RECONNECT, true);
	
	db = mysql_connect("127.0.0.1", "root", "", "message", opt);
	mysql_log(ALL);
	
	if(mysql_errno(db) != 0 || db == MYSQL_INVALID_HANDLE)
	{
	    print("» Mesaj sistemi yüklenmedi, MySQL bağlantısı başarısız.");
	}
	else
	{
	    print("» Mesaj sistemi yüklendi, MySQL bağlantısı başarılı!");
	    Messages_CreateTable();
	    Messages_Load();
	}
	return true;
}

public OnFilterScriptExit()
{
	mysql_close(db);
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
        if(dialogid == DIALOG_MESSAGE)
        {
                if(!response) return true;
                if(response)
                {
                        new edt[50], id;
                        format(edt, sizeof(edt), "m_%d", listitem);
                        id = GetPVarInt(playerid, edt);
                        Messages_ShowMessage(playerid, id, listitem);
                }
        }

        if(dialogid == DIALOG_MESSAGE_READ)
        {
                Messages_ShowDialog(playerid);
        }

        if(dialogid == DIALOG_MESSAGE_SEND_1)
        {
                if(!response) return true;
                if(response)
                {
                        if(!strlen(inputtext) || isnull(inputtext) || strfind(inputtext, " ", true) != -1 || strlen(inputtext) > 35) return ShowPlayerDialog(playerid, DIALOG_MESSAGE_SEND_1, DIALOG_STYLE_INPUT, "Mesaj Gönder", "{00B6E9}» {FFFFFF}Mesaj başlığını girin:", "İleri", "Kapat");

                        SetPVarString(playerid, "s_b", inputtext);
                        ShowPlayerDialog(playerid, DIALOG_MESSAGE_SEND_2, DIALOG_STYLE_INPUT, "Mesaj Gönder", "{00B6E9}» {FFFFFF}Mesaj içeriğini girin:", "İleri", "Kapat");
                }
        }

        if(dialogid == DIALOG_MESSAGE_SEND_2)
        {
                if(!response) return ShowPlayerDialog(playerid, DIALOG_MESSAGE_SEND_1, DIALOG_STYLE_INPUT, "Mesaj Gönder", "{00B6E9}» {FFFFFF}Mesaj başlığını girin:", "İleri", "Kapat");
                if(response)
                {
                        if(!strlen(inputtext) || isnull(inputtext) || strfind(inputtext, " ", true) != -1 || strlen(inputtext) > 1024) return ShowPlayerDialog(playerid, DIALOG_MESSAGE_SEND_1, DIALOG_STYLE_INPUT, "Mesaj Gönder", "{00B6E9}» {FFFFFF}Mesaj başlığını girin:", "İleri", "Kapat");

                        new b[35];
                        GetPVarString(playerid, "s_b", b, 35);
                        Messages_Send(GetPVarInt(playerid, "s_id"), playerid, b, inputtext);
                }
        }
	return false;
}

CMD:mesajlarim(playerid)
{
	Messages_ShowDialog(playerid);
	return true;
}

CMD:mesajgonder(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SCM(playerid, "/mesajgonder [id/isim]");
	if(!IsPlayerConnected(id)) return SCM(playerid, "Oyuncu oyunda değil!");
	SetPVarInt(playerid, "s_id", id);
	ShowPlayerDialog(playerid, DIALOG_MESSAGE_SEND_1, DIALOG_STYLE_INPUT, "Mesaj Gönder", "{00B6E9}» {FFFFFF}Mesaj başlığını girin:", "İleri", "Kapat");
	return true;
}

stock Messages_Load()
{
	new Cache: veri = mysql_query(db, "SELECT * FROM `messages`");
	new rows = cache_num_rows(), yuklenen, id;
	
	if(rows)
	{
	    while(yuklenen < rows)
	    {
	        cache_get_value_name_int(yuklenen, "id", id);
	        mData[id][mID] = id;
	        cache_get_value_name_int(yuklenen, "readx", mData[id][mOkunma]);
	        cache_get_value_name(yuklenen, "user", mData[id][mKullanici], 24);
	        cache_get_value_name(yuklenen, "title", mData[id][mBaslik], 35);
	        cache_get_value_name(yuklenen, "message", mData[id][mMesaj], 1024);
	        Iter_Add(mesajlar, id);
	        yuklenen++;
	    }
	}
	
	cache_delete(veri);
	return true;
}

stock Messages_ShowDialog(playerid)
{
	new str[2048], edt[50], slot;
	strcat(str, "{c0c0c0}Başlık\t{c0c0c0}Durum\n");
	
        foreach(new i: mesajlar)
        {
                if(strcmp(mData[i][mKullanici], getName(playerid)) == 0)
                {
                        format(edt, sizeof(edt), "m_%d", slot);
                        SetPVarInt(playerid, edt, i);
                        format(str, sizeof(str), "%s{00B6E9}%s\t%s\n", str, mData[i][mBaslik], (mData[i][mOkunma] == 0 ? ("{00FF00}Okunmamış") : ("{FF0000}Okunmuş")));
                        slot++;
                }
        }
	
	ShowPlayerDialog(playerid, DIALOG_MESSAGE, DIALOG_STYLE_TABLIST_HEADERS, "Mesajlarım", str, "Seç", "Kapat");
	return true;
}

stock Messages_ShowMessage(playerid, id, slot)
{
	if(mData[id][mID] != id) return true;
        if(strcmp(mData[id][mKullanici], getName(playerid)) != 0) return true;
        mData[id][mOkunma] = 1;
        new str[1600];
        format(str, sizeof(str), "{00B6E9}%s\n\n\
                                        {c0c0c0}%s", mData[id][mBaslik], Messages_TextFix(mData[id][mMesaj], strlen(mData[id][mMesaj])));
        ShowPlayerDialog(playerid, DIALOG_MESSAGE_READ, DIALOG_STYLE_MSGBOX, "Mesaj", str, "Geri", "");

	Messages_Update(id);
	
	static d[6];
	format(d, sizeof(d), "m_%d", slot);
	DeletePVar(playerid, d);
	return true;
}

stock Messages_Update(id)
{
        new sql[128];
        mysql_format(db, sql, sizeof(sql), "UPDATE `messages` SET `readx` = '%d' WHERE `id` = '%d'", mData[id][mOkunma], id);
        mysql_query(db, sql, false);
	return true;
}

stock Messages_Send(playerid, gonderen, baslik[], metin[])
{
	new id = Iter_Free(mesajlar), sql[2048];
	if(id == -1)
	{
	    print("» Mesaj sınırı aşılmış!");
	    SCM(gonderen, "Mesaj sınırı aşılmış, mesajınız gönderilemedi.");
		return false;
	}
	if(strlen(baslik) > 35) return true;
	if(strlen(metin) > 1024) return true;
	
	mData[id][mID] = id;
	mData[id][mOkunma] = 0;
	format(mData[id][mKullanici], 24, getName(playerid));
	format(mData[id][mBaslik], 35, baslik);
	format(mData[id][mMesaj], 1024, metin);
	
	Iter_Add(mesajlar, id);
	mysql_format(db, sql, sizeof(sql), "INSERT INTO `messages` (`id`, `readx`, `user`, `title`, `message`) VALUES ('%d', '%d', '%e', '%e', '%e')", id, 0, getName(playerid), baslik, metin);
	mysql_query(db, sql, false);
	
	DeletePVar(gonderen, "s_id");
	DeletePVar(gonderen, "s_b");
	
	SCM(playerid, "Yeni bir mesajınız var! (/mesajlarim)");
	SCM(gonderen, "Mesajınız başarıyla iletildi.");
	return true;
}

stock Messages_TextFix(str[], length)
{
	new strX[2048];
	strcat(strX, str);
	if(length <= 144) return strX;
	new Float: x = floatdiv(length, 144);
	for(new i; i < floatround(x); i++)
	{
	    strins(strX, "\n{c0c0c0}", (144 * (i + 1)));
	}
	return strX;
}

stock Messages_CreateTable()
{
	mysql_query(db, "CREATE TABLE IF NOT EXISTS `messages` (\
	`id` int(11) NOT NULL,\
	`readx` int(11) NOT NULL,\
	`user` varchar(24) NOT NULL,\
	`title` varchar(35) NOT NULL,\
	`message` varchar(1024) NOT NULL\
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;", false);
	
	mysql_query(db, "ALTER TABLE `messages`\
	ADD UNIQUE KEY `id` (`id`);", false);
	return true;
}

stock getName(playerid)
{
	new x[24] = _:0.0;
	GetPlayerName(playerid, x, 24);
	return x;
}
