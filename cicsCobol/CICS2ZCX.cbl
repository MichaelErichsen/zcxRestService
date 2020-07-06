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
          03 PATHLENGTH     PIC S9(8) USAGE BINARY.
          03 MAXLENGTH      PIC S9(8) USAGE BINARY.
          03 TOLENGTH       PIC S9(8) USAGE BINARY.
          03 STATUSCODEBIN  PIC S9(4) USAGE BINARY.
          03 STATUSCODE     PIC 9(4) USAGE DISPLAY.
          03 STATUSLENGTH   PIC S9(8) USAGE BINARY.
          03 MEDIATYPE      PIC X(56).
          03 MSGLENGTH      PIC S9(4) USAGE BINARY.
          03 PATH           PIC X(80).
          03 STATUSTEXT     PIC X(80).
          03 RESPONSE       PIC X(512).
          03 MSGOUT         PIC X(1024).
       PROCEDURE DIVISION.
       MAIN SECTION.
           PERFORM INITIALIZATION.
           PERFORM WEB-CONVERSATION.
           PERFORM USER-RESPONSE.
           EXEC CICS RETURN
                END-EXEC.
           GOBACK.
       INITIALIZATION.
           INITIALIZE WS.
           MOVE '192.168.10.199' TO HOST.
           MOVE 14 TO HOSTLENGTH.
           MOVE 80 TO PORTNUMBER.
           MOVE '/api/person' TO PATH.
           MOVE 11 TO PATHLENGTH.
           MOVE 512 TO MAXLENGTH.
           MOVE 80 TO STATUSLENGTH.
       WEB-CONVERSATION.
           EXEC CICS WEB OPEN HTTP
                HOST(HOST)
                HOSTLENGTH(HOSTLENGTH)
                PORTNUMBER(PORTNUMBER)
                SESSTOKEN(SESSTOKEN)
                END-EXEC.
           EXEC CICS WEB CONVERSE GET
                SESSTOKEN(SESSTOKEN)
                PATH(PATH) PATHLENGTH(PATHLENGTH)
                INTO (RESPONSE)
                MAXLENGTH(MAXLENGTH)
                TOLENGTH(TOLENGTH)
                STATUSCODE(STATUSCODEBIN)
                STATUSTEXT(STATUSTEXT)
                STATUSLEN(STATUSLENGTH)
                MEDIATYPE(MEDIATYPE)
                END-EXEC.
           EXEC CICS WEB CLOSE
                SESSTOKEN(SESSTOKEN)
                END-EXEC.
       USER-RESPONSE.
           MOVE STATUSCODEBIN TO STATUSCODE.
           INSPECT RESPONSE
              REPLACING ALL x'0d25'
              BY '  '.
           STRING STATUSCODE DELIMITED BY SIZE
                  ' ' DELIMITED BY SIZE
                  STATUSTEXT(1:STATUSLENGTH) DELIMITED BY SIZE
                  ' ' DELIMITED BY SIZE
                  RESPONSE(1:TOLENGTH)  DELIMITED BY SIZE
              INTO MSGOUT
           END-STRING.
           COMPUTE MSGLENGTH = 6 + STATUSLENGTH + TOLENGTH.
           EXEC CICS SEND TEXT ERASE FREEKB
                FROM (MSGOUT)
                LENGTH(MSGLENGTH)
                END-EXEC.