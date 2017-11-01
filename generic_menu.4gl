PUBLIC TYPE generic_menu_type RECORD
    style STRING,
    image STRING,
    comment STRING,
    items DYNAMIC ARRAY OF RECORD
        name, text, item_comment, item_image STRING
    END RECORD
END RECORD



FUNCTION execute(design)
DEFINE design generic_menu_type

DEFINE i INTEGER
DEFINE selection INTEGER

   MENU "Generic Menu" ATTRIBUTES(STYLE=design.style, IMAGE=design.image, COMMENT=design.comment)
      BEFORE MENU
         FOR i = 1 TO 20
            IF i <= design.items.getLength() THEN
               CALL DIALOG.setActionHidden(SFMT("action%1", i USING "&&"),FALSE)
               CALL DIALOG.setActionText(SFMT("action%1", i USING "&&"),design.items[i].text)
               CALL DIALOG.setActionImage(SFMT("action%1", i USING "&&"),design.items[i].item_image)
               CALL DIALOG.setActionComment(SFMT("action%1", i USING "&&"),design.items[i].item_comment)
            ELSE
               -- Hide those actions that haven't been defined
               CALL DIALOG.setActionHidden(SFMT("action%1", i USING "&&"),TRUE)
               CALL DIALOG.setActionText(SFMT("action%1", i USING "&&"),"")
               CALL DIALOG.setActionImage(SFMT("action%1", i USING "&&"),"")
               CALL DIALOG.setActionComment(SFMT("action%1", i USING "&&"),"")
            END IF
         END FOR
                       
       -- Determine what action was selected
&define menuline(p1) ON ACTION action ## p1 LET selection = p1 EXIT MENU
      menuline(01)
      menuline(02)
      menuline(03)
      menuline(04)
      menuline(05)
      menuline(06)
      menuline(07)
      menuline(08)
      menuline(09)
      menuline(10)
      menuline(11)
      menuline(12)
      menuline(13)
      menuline(14)
      menuline(15)
      menuline(16)
      menuline(17)
      menuline(18)
      menuline(19)
      menuline(20)
&undef menuline
      ON ACTION close
        LET selection = 0
        EXIT MENU
   END MENU 

   RETURN selection
END FUNCTION