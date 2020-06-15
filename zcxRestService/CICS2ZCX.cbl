       IDENTIFICATION DIVISION.
       PROGRAM-ID. CICS2ZCX.
       AUTHOR. Michael Erichsen, Xact Consulting.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS.
          03 HOST           PIC X(16).
          03 HOSTLENGTH     PIC S9(8) USAGE BINARY.
          03 PORTNUMBER     PIC S9(8) USAGE BINARY.
          03 SESSTOKEN      PIC X(8).
          03 PATH           PIC X(80).
          03 PATHLENGTH     PIC S9(8) USAGE BINARY.
          03 RESPONSE       PIC X(512).
          03 MAXLENGTH      PIC S9(8) USAGE BINARY.
          03 TOLENGTH       PIC S9(8) USAGE BINARY.
          03 STATUSCODEBIN  PIC S9(8) USAGE BINARY.
          03 STATUSCODE     PIC X(4).
          03 STATUSTEXT     PIC X(80).
          03 STATUSLENGTH   PIC S9(8) USAGE BINARY.
          03 MEDIATYPE      PIC X(56).
          03 MSGLENGTH      PIC S9(4) USAGE BINARY.

       PROCEDURE DIVISION .
           INITIALIZE WS.
           MOVE '192.168.10.199' TO HOST.
           MOVE 14 TO HOSTLENGTH.
           MOVE 80 TO PORTNUMBER.
           MOVE '/api/person' TO PATH.
           MOVE 11 TO PATHLENGTH.
           MOVE 512 TO MAXLENGTH.
           MOVE 80 TO STATUSLENGTH.

           EXEC CICS WEB OPEN
                HTTP
                HOST(HOST)
                HOSTLENGTH(HOSTLENGTH)
                PORTNUMBER(PORTNUMBER)
                SESSTOKEN(SESSTOKEN)
                END-EXEC.

           EXEC CICS WEB CONVERSE
                SESSTOKEN(SESSTOKEN)
                PATH(PATH) PATHLENGTH(PATHLENGTH)
                GET
                INTO (RESPONSE)
                MAXLENGTH(MAXLENGTH)
                TOLENGTH(TOLENGTH)
                STATUSCODE(STATUSCODE)
                STATUSTEXT(STATUSTEXT)
                STATUSLEN(STATUSLENGTH)
                MEDIATYPE(MEDIATYPE)
                END-EXEC.



           MOVE STATUSCODEBIN TO STATUSCODE.

           IF STATUSCODE = 200 THEN
              MOVE TOLENGTH TO MSGLENGTH
              EXEC CICS SEND TEXT ERASE FREEKB
                   FROM (RESPONSE)
                   LENGTH(MSGLENGTH)
                   END-EXEC
           ELSE
              MOVE STATUSLENGTH TO MSGLENGTH
              EXEC CICS SEND TEXT ERASE FREEKB
                   FROM (STATUSTEXT)
                   LENGTH(MSGLENGTH)
                   END-EXEC
           END-IF.

           EXEC CICS WEB CLOSE
                SESSTOKEN(SESSTOKEN)
                END-EXEC.

           EXEC CICS RETURN
                END-EXEC.
           GOBACK.

