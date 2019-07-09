PUBLIC TYPE generic_menu_type RECORD
    style STRING,
    image STRING,
    comment STRING,
    items DYNAMIC ARRAY OF RECORD
        name, text, item_image, item_accelerator, item_comment  STRING
    END RECORD
END RECORD



FUNCTION (this generic_menu_type)init() RETURNS ()
    INITIALIZE this.* TO NULL
END FUNCTION



FUNCTION (this generic_menu_type)execute() RETURNS INTEGER
DEFINE i INTEGER
DEFINE selection INTEGER
DEFINE initial_length INTEGER

    # have to save initial length and use as the MENU will corrupt the length to 20
    LET initial_length = this.items.getLength()

    MENU "Generic Menu" ATTRIBUTES(STYLE=this.style, IMAGE=this.image, COMMENT=this.comment)
        BEFORE MENU
            FOR i = 1 TO 20
                IF i <= initial_length THEN
                    CALL DIALOG.setActionActive(SFMT("action%1", i USING "&&"),TRUE)
                    CALL DIALOG.setActionHidden(SFMT("action%1", i USING "&&"),FALSE)
                ELSE
                    -- Hide those actions that haven't been defined
                    CALL DIALOG.setActionActive(SFMT("action%1", i USING "&&"),FALSE)
                    CALL DIALOG.setActionHidden(SFMT("action%1", i USING "&&"),TRUE)
            END IF
         END FOR
                       
       -- Determine what action was selected
&define menuline(p1) ON ACTION action ## p1 ATTRIBUTES(TEXT=this.items[p1].text, \
                                                       COMMENT=this.items[p1].item_comment, \
                                                       IMAGE=this.items[p1].item_image, \
                                                       ACCELERATOR=this.items[p1].item_accelerator) \
                       LET selection = p1 EXIT MENU
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

    # As dynamic array passed by reference, have to remove menu entries unintentionally added when referenced in array
    FOR i = 20 TO (initial_length+1) STEP -1
        CALL this.items.deleteElement(i)
    END FOR

   RETURN selection
END FUNCTION