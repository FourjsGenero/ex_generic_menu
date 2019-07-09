-- Data structure used to define the presentation of a generic menu.
IMPORT FGL generic_menu


MAIN
DEFINE selection INTEGER
DEFINE test_menu generic_menu.generic_menu_type

    OPTIONS FIELD ORDER FORM
    OPTIONS INPUT WRAP
    CLOSE WINDOW SCREEN

    OPEN WINDOW w WITH FORM "generic_menu_test"
   
    -- Initial values
    LET test_menu.style = "dialog"    
    LET test_menu.image = "question"
    LET test_menu.comment="Select an item"

    LET test_menu.items[1].name = "print"
    LET test_menu.items[1].text = "Print"
    LET test_menu.items[1].item_image = "fa-print"
    LEt test_menu.items[1].item_accelerator = "Control-P"
    LET test_menu.items[1].item_comment = "Print file to printer"
   
    LET test_menu.items[2].name = "email"
    LET test_menu.items[2].text = "Email"
    LET test_menu.items[2].item_image = "fa-envelope-o"
    LEt test_menu.items[2].item_accelerator = "Control-E"
    LET test_menu.items[2].item_comment = "Email file"
   
    LET test_menu.items[3].name = "save"
    LET test_menu.items[3].text = "Save"
    LET test_menu.items[3].item_image = "fa-save"
    LEt test_menu.items[3].item_accelerator = "Control-S"
    LET test_menu.items[3].item_comment = "Save file to disk"

    LET test_menu.items[4].name = "refresh"
    LET test_menu.items[4].text = "Refresh"
    LET test_menu.items[4].item_image = "fa-sync"
    LEt test_menu.items[4].item_accelerator = "F5"
    LET test_menu.items[4].item_comment = "Refresh"

    -- Input the criteria for the menu and then display it
    DIALOG ATTRIBUTES(UNBUFFERED)
        INPUT BY NAME test_menu.style,
                      test_menu.image,
                      test_menu.comment ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT
        INPUT ARRAY test_menu.items  FROM scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE, MAXCOUNT=20)
        END INPUT
        ON ACTION menu
            CALL test_menu.execute() RETURNING selection
            IF selection > 0 THEN
                CALL FGL_WINMESSAGE("Info", SFMT("Value selected is %1", test_menu.items[selection].text),"info")
            ELSE
                 CALL FGL_WINMESSAGE("Info", "No selection made","warn")
                END IF
        ON ACTION view_source ATTRIBUTES (TEXT="View Source")
            CALL view_source(test_menu.*)
        ON ACTION close
            EXIT DIALOG
    END DIALOG
END MAIN



PRIVATE FUNCTION view_source(test_menu)
DEFINE test_menu generic_menu.generic_menu_type
DEFINE sb base.StringBuffer
DEFINE i INTEGER

    LET sb = base.StringBuffer.create()
    CALL sb.append("IMPORT FGL generic_menu")
    CALL sb.append("\n")

    CALL sb.append("\nDEFINE menu generic_menu.generic_menu_type")
    CALL sb.append("\n")
    IF test_menu.style IS NOT NULL THEN
        CALL sb.append(SFMT("\nLET menu.style='%1'", test_menu.style))
    END IF   
    IF test_menu.image IS NOT NULL THEN
        CALL sb.append(SFMT("\nLET menu.image='%1'", test_menu.image))
    END IF
    IF test_menu.comment IS NOT NULL THEN
        CALL sb.append(SFMT("\nLET menu.comment='%1'", test_menu.comment))
    END IF
    
    CALL sb.append("\n")
    FOR i = 1 TO test_menu.items.getLength()
        IF test_menu.items[i].name IS NOT NULL THEN
            CALL sb.append(SFMT("\nLET menu.items[%2].name='%1'", test_menu.items[i].name,i))
        END IF 
        IF test_menu.items[i].text IS NOT NULL THEN
            CALL sb.append(SFMT("\nLET menu.items[%2].text='%1'", test_menu.items[i].text,i))
        END IF 
        IF test_menu.items[i].item_image IS NOT NULL THEN
            CALL sb.append(SFMT("\nLET menu.items[%2].item_image='%1'", test_menu.items[i].item_image,i))
        END IF 
        IF test_menu.items[i].item_accelerator IS NOT NULL THEN
            CALL sb.append(SFMT("\nLET menu.items[%2].item_accelerator='%1'", test_menu.items[i].item_accelerator,i))
        END IF 
        IF test_menu.items[i].item_comment IS NOT NULL THEN
            CALL sb.append(SFMT("\nLET menu.items[%2].item_comment='%1'", test_menu.items[i].item_comment,i))
        END IF 
        
       
        CALL sb.append("\n")
    END FOR
    CALL sb.append("\nLET selection = menu.execute()")

    CALL FGL_WINMESSAGE("Source", sb.toString(),"info")

END FUNCTION