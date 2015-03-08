#!/usr/bin/env python3

import re
from os import chdir
from glob import glob

# some variables
div_testament = 0
div_book = 0
div_chapter = 0
book_abbr = {
        '01':{'Genèse':'Gen'},
        '02':{'Exode':'Exod'},
        '03':{'Lévitique':'Lev'},
        '04':{'Nombres':'Num'},
        '05':{'Deutéronome':'Deut'},
        '06':{'Josué':'Josh'},
        '07':{'Juges':'Judg'},
        '08':{'Ruth':'Ruth'},
        '09':{'1 Samuel':'1Sam'},
        '10':{'2 Samuel':'2Sam'},
        '11':{'1 Rois':'1Kgs'},
        '12':{'2 Rois':'2Kgs'},
        '13':{'1 Chroniques':'1Chr'},
        '14':{'2 Chroniques':'2Chr'},
        '15':{'Esdras':'Ezra'},
        '16':{'Néhémie':'Neh'},
        '17':{'Esther':'Esth'},
        '18':{'Job':'Job'},
        '19':{'Psaumes':'Ps'},
        '20':{'Proverbes':'Prov'},
        '21':{'Ecclésiaste':'Ecc'},
        '22':{'Cantique des cantiques':'Song'},
        '23':{'Esaïe':'Isa'},
        '24':{'Jérémie':'Jer'},
        '25':{'Lamentations de Jérémie':'Lam'},
        '26':{'Ezéchiel':'Ezek'},
        '27':{'Daniel':'Dan'},
        '28':{'Osée':'Hos'},
        '29':{'Joël':'Joel'},
        '30':{'Amos':'Amos'},
        '31':{'Abdias':'Obad'},
        '32':{'Jonas':'Jonah'},
        '33':{'Michée':'Mic'},
        '34':{'Nahum':'Nah'},
        '35':{'Habakuk':'Hab'},
        '36':{'Sophonie':'Zeph'},
        '37':{'Aggée':'Hag'},
        '38':{'Zacharie':'Zech'},
        '39':{'Malachie':'Mal'},
        '40':{'Matthieu':'Matt'},
        '41':{'Marc':'Mark'},
        '42':{'Luc':'Luke'},
        '43':{'Jean':'John'},
        '44':{'Actes':'Acts'},
        '45':{'Romains':'Rom'},
        '46':{'1 Corinthiens':'1Cor'},
        '47':{'2 Corinthiens':'2Cor'},
        '48':{'Galates':'Gal'},
        '49':{'Ephésiens':'Eph'},
        '50':{'Philippiens':'Phil'},
        '51':{'Colossiens':'Col'},
        '52':{'1 Thessaloniciens':'1Thess'},
        '53':{'2 Thessaloniciens':'2Thess'},
        '54':{'1 Timothée':'1Tim'},
        '55':{'2 Timothée':'2Tim'},
        '56':{'Tite':'Titus'},
        '57':{'Philémon':'Phlm'},
        '58':{'Hébreux':'Heb'},
        '59':{'Jacques':'Jas'},
        '60':{'1 Pierre':'1Pet'},
        '61':{'2 Pierre':'2Pet'},
        '62':{'1 Jean':'1John'},
        '63':{'2 Jean':'2John'},
        '64':{'3 Jean':'3John'},
        '65':{'Jude':'Jude'},
        '66':{'Apocalypse':'Rev'},
    }

# source files
src_dir = '../txt/BJC/'
chdir(src_dir)
list_files = sorted(glob('*.txt'))

# output file
out_file = '../../xml/bjc.xml'
data_w = open(out_file,'w')

# print header
data_w.write('<?xml version="1.0" encoding="utf-8"?>\n')
data_w.write('<XMLBIBLE xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="zef2005.xsd" version="2.0.1.18" status="v" biblename="Bible Martin 1744" type="x-bible" revision="0">\n')
data_w.write('<INFORMATION>\n')
data_w.write('\t<subject>Bible</subject>\n')
data_w.write('\t<publisher>ANJC Productions</publisher>\n')
data_w.write('\t<format>Zefania XML Bible Markup Language</format>\n')
data_w.write('\t<date>2014-08-24</date>\n')
data_w.write('\t<title>Bible de Jésus-Christ</title>\n')
data_w.write('\t<contributors>Sword</contributors>\n')
data_w.write('\t<type>bible text</type>\n')
data_w.write('\t<identifier>BJC2014</identifier>\n')
data_w.write('\t<source>http://www.bible-de-jesus.org</source>\n')
data_w.write('\t<language>FRE</language>\n')
data_w.write('\t<coverage>provide the bible to the world</coverage>\n')
data_w.write('\t<rights>\n')
data_w.write('\t</rights>\n')
data_w.write('\t<creator />\n')
data_w.write('\t<description />\n')
data_w.write('</INFORMATION>\n')

# browse each source files
for file_name in list_files :
    # get book name
    book_data = re.split('-|\.',file_name)
    book_num = book_data[0]
    book_name = book_data[1]

    # if new book
    if (div_book == 0) :
        data_w.write('<BIBLEBOOK bnumber="'+book_num+'" bname="'+book_name+'" bsname="'+book_abbr[book_num][book_name]+'">\n')
        div_book = 1

    # open and read file
    data_r = open(file_name,'r')
    list_lines = data_r.readlines()

    # browse each line of the file
    for line in list_lines :
        # filter book name like : 2 Corinthiens 5
        if re.search(r'^\d\s+[A-Za-zéèêëîïôÉÈÊËÎÏ]+\s*\d+\s*', line) :
            line = line.split(' ')
            bname = line[0]+' '+line[1].rstrip()
            cnumber = line[2].rstrip()
            if (div_chapter == 0) :
                data_w.write('\t<CHAPTER cnumber="'+cnumber+'">\n')
                div_chapter = 1
            else :
                data_w.write('\t</CHAPTER>\n')
                data_w.write('\t<CHAPTER cnumber="'+cnumber+'">\n')
        # filter book name like : Romains 16
        elif re.search(r'^[A-Za-zéèêëîïôÉÈÊËÎÏ]+\s*\d+\s*', line) :
            line = line.split(' ',1)
            bname = line[0].rstrip()
            cnumber = line[1].rstrip()
            if (div_chapter == 0) :
                data_w.write('\t<CHAPTER cnumber="'+cnumber+'">\n')
                div_chapter = 1
            else :
                data_w.write('\t</CHAPTER>\n')
                data_w.write('\t<CHAPTER cnumber="'+cnumber+'">\n')
        # otherwise it is a verse
        else :
            line = line.split(' ',1)
            vnumber = line[0].rstrip()
            vtext = line[1].rstrip()
            data_w.write('\t\t<VERS vnumber="'+vnumber+'">'+vtext+'</VERS>\n')

    # end of book
    data_r.close()
    data_w.write('\t</CHAPTER>\n')
    data_w.write('</BIBLEBOOK>\n')
    div_book = 0
    div_chapter = 0

data_w.write('</XMLBIBLE>\n')

data_w.close()

