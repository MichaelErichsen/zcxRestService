       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALLZCXS.
       AUTHOR. Michael Erichsen, Xact Consulting.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS.
          03 HOST           PIC X(16).
          03 HOSTLENGTH     PIC S9(8) USAGE BINARY.
          03 PORTNUMBER     PIC S9(8) USAGE BINARY.
          03 SESSTOKEN      PIC S9(8) USAGE BINARY.
          03 PATH           PIC X(80).
          03 PATHLENGTH     PIC S9(8) USAGE BINARY.
          03 RESPONSE       PIC X(80).
          03 MAXLENGTH      PIC S9(8) USAGE BINARY.
          03 TOLENGTH       PIC S9(8) USAGE BINARY.
          03 STATUSCODEBIN  PIC S9(8) USAGE BINARY.
          03 STATUSCODE     PIC X(4).
          03 STATUSTEXT     PIC X(80).
          03 STATUSLENGTH   PIC S9(8) USAGE BINARY.
          03 MEDIATYPE      PIC X(56).
          03 MESSAGELENGTH  PIC S9(8) USAGE BINARY.
          03 MESSAGEOUT     PIC X(255).


       PROCEDURE DIVISION .
           INITIALIZE WS.
           MOVE '192.168.10.199' TO HOST.
           MOVE 14 TO HOSTLENGTH.
           MOVE 8080 TO PORTNUMBER.
           MOVE '/api/person' TO PATH.
           MOVE 11 TO PATHLENGTH.
           MOVE 80 TO MAXLENGTH.

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

           EXEC CICS WEB CLOSE
                SESSTOKEN(SESSTOKEN)
                END-EXEC.

           MOVE STATUSCODEBIN TO STATUSCODE.

           STRING STATUSCODE DELIMITED BY SIZE
                  STATUSTEXT DELIMITED BY SIZE
                  RESPONSE DELIMITED BY SIZE
              INTO MESSAGEOUT
           END-STRING.

           COMPUTE MESSAGELENGTH = 6 + STATUSLENGTH + TOLENGTH.

           EXEC CICS SEND TEXT
                FROM (MESSAGEOUT)
                LENGTH(MESSAGELENGTH)
                END-EXEC.

           EXEC CICS RETURN
                END-EXEC.
           GOBACK.

