--
-- Copyright (c) 1997 by Oracle Corporation. All Rights Reserved. 
--
load data
infile *
preserve blanks
into table help append
fields terminated by '^'
TRAILING NULLCOLS
(
    topic, seq, info
)
BEGINDATA
ACCEPT^1^ 
ACCEPT^2^ ACCEPT
ACCEPT^3^ ------
ACCEPT^4^ 
ACCEPT^5^ ACCEPT reads a line of input and stores it in a given user variable.
ACCEPT^6^ 
ACCEPT^7^ ACC[EPT] variable [NUM[BER]|CHAR|DATE] [FOR[MAT] format]
ACCEPT^8^   [DEF[AULT] default] [PROMPT text|NOPR[OMPT]] [HIDE]
ACCEPT^9^ 
ACCEPT^10^ For detailed information on this command, see the SQL*Plus User's 
ACCEPT^11^ Guide and Reference.
ACCEPT^12^ 
APPEND^1^ 
APPEND^2^ APPEND
APPEND^3^ ------
APPEND^4^ 
APPEND^5^ Use APPEND to add text to the end of the current line in the SQL 
APPEND^6^ buffer.
APPEND^7^ 
APPEND^8^ A[PPEND] text 
APPEND^9^ 
APPEND^10^ For detailed information on this command, see the SQL*Plus User's 
APPEND^11^ Guide and Reference.
APPEND^12^ 
@^1^ 
@^2^ @ ("at" sign)
@^3^ -------------
@^4^ 
@^5^ Runs the specified command file.
@^6^ 
@^7^ @ file_name[.ext] [arg...]
@^8^ 
@^9^ For detailed information on this command, see the SQL*Plus User's 
@^10^ Guide and Reference.
@^11^ 
@@^1^ 
@@^2^ @@ (double "at" sign)
@@^3^ ---------------------
@@^4^ 
@@^5^ Runs a nested command file. This command is identical to the @
@@^6^ command except that it looks for the specified command file in the
@@^7^ same path as the command file from which it was called.
@@^8^ 
@@^9^ @@ file_name[.ext]
@@^10^ 
@@^11^ For detailed information on this command, see the SQL*Plus User's 
@@^12^ Guide and Reference.
@@^13^ 
ATTRIBUTE^1^ 
ATTRIBUTE^2^ ATTRIBUTE
ATTRIBUTE^3^ ---------
ATTRIBUTE^4^ 
ATTRIBUTE^5^ ATTRIBUTE specifies display characteristics for a given attribute of 
ATTRIBUTE^6^ an Object Type column, such as format for NUMBER data.
ATTRIBUTE^7^ 
ATTRIBUTE^8^ Also lists the current display characteristics for a single 
ATTRIBUTE^9^ attribute or all attributes.
ATTRIBUTE^10^ 
ATTRIBUTE^11^ ATTRIBUTE [type_name.attribute_name [option... ]]
ATTRIBUTE^12^ where option represents one of the following terms or clauses:
ATTRIBUTE^13^ 
ATTRIBUTE^14^     ALI[AS]
ATTRIBUTE^15^     CLE[AR]
ATTRIBUTE^16^     FOR[MAT]
ATTRIBUTE^17^     LIKE
ATTRIBUTE^18^     ON|OFF
ATTRIBUTE^19^ 
ATTRIBUTE^20^ For detailed information on this command, see the SQL*Plus User's 
ATTRIBUTE^21^ Guide and Reference.
ATTRIBUTE^22^ 
BREAK^1^ 
BREAK^2^ BREAK
BREAK^3^ -----
BREAK^4^ 
BREAK^5^ BREAK specifies where and how to make format changes to a report.
BREAK^6^
BREAK^7^ BRE[AK] [ON report_element [action [action]]] ...
BREAK^8^ 
BREAK^9^ where report_element and action require the following syntax:
BREAK^10^         report_element: {column | expression | ROW | REPORT}
BREAK^11^         action: [SKI[P] n|[SKI[P]] PAGE] [NODUP[LICATES] |
BREAK^12^         DUP[LICATES]]
BREAK^13^ 
BREAK^14^ For detailed information on this command, see the SQL*Plus User's 
BREAK^15^ Guide and Reference.
BREAK^16^ 
BTITLE^1^ 
BTITLE^2^ BTITLE
BTITLE^3^ ------
BTITLE^4^ 
BTITLE^5^ BTITLE places and formats a title at the bottom of each report page, 
BTITLE^6^ or lists the current BTITLE definition.
BTITLE^7^ 
BTITLE^8^ BTI[TLE] [printspec [text | variable] ...] | [OFF|ON]
BTITLE^9^ 
BTITLE^10^ For detailed information on this command, see the SQL*Plus User's 
BTITLE^11^ Guide and Reference.
BTITLE^12^ 
CHANGE^1^ 
CHANGE^2^ CHANGE
CHANGE^3^ ------
CHANGE^4^ 
CHANGE^5^ Use CHANGE to replace the first occurrence of the specified text on 
CHANGE^6^ the current line of the buffer with the new specified text.
CHANGE^7^
CHANGE^8^ C[HANGE] sepchar old [sepchar [new[sepchar]]]
CHANGE^9^ 
CHANGE^10^ For detailed information on this command, see the SQL*Plus User's 
CHANGE^11^ Guide and Reference.
CHANGE^12^ 
CLEAR^1^ 
CLEAR^2^ CLEAR
CLEAR^3^ -----
CLEAR^4^ 
CLEAR^5^ CLEAR resets or erases the current value or setting for the option, 
CLEAR^6^ 
CLEAR^7^ CL[EAR] option ...
CLEAR^8^ 
CLEAR^9^ where option is one of the following clauses:
CLEAR^10^ 
CLEAR^11^     BRE[AKS]
CLEAR^12^     BUFF[ER]
CLEAR^13^     COL[UMNS]
CLEAR^14^     COMP[UTES]
CLEAR^15^     SCR[EEN]
CLEAR^16^     SQL
CLEAR^17^     TIMI[NG]
CLEAR^18^ 
CLEAR^19^ For detailed information on this command, see the SQL*Plus User's 
CLEAR^20^ Guide and Reference.
CLEAR^21^ 
COLUMN^1^ 
COLUMN^2^ COLUMN
COLUMN^3^ ------
COLUMN^4^ 
COLUMN^5^ COLUMN sets display attributes for a given column, such as:
COLUMN^6^ 
COLUMN^7^     -   text for the column heading
COLUMN^8^     -   alignment of the column heading
COLUMN^9^     -   format for NUMBER data
COLUMN^10^     -   wrapping of column data
COLUMN^11^ 
COLUMN^12^ COL[UMN] [{column | expr} [option...] ]
COLUMN^13^ 
COLUMN^14^ where option is one of the following:
COLUMN^15^ 
COLUMN^16^     ALI[AS] alias
COLUMN^17^     CLE[AR] | DEF[AULT]
COLUMN^18^     FOLD_A[FTER] n
COLUMN^19^     FOLD_B[EFORE] n
COLUMN^20^     FOR[MAT] format
COLUMN^21^     HEA[DING] text
COLUMN^22^     JUS[TIFY] {L[EFT] | C[ENTER] | C[ENTRE] | R[IGHT]}
COLUMN^23^     LIKE {expr | alias}
COLUMN^24^     NEWL[INE]
COLUMN^25^     NEW_V[ALUE] variable
COLUMN^26^     NOPRI[NT] | PRI[NT]
COLUMN^27^     NUL[L] text
COLUMN^28^     OLD_V[ALUE] variable
COLUMN^29^     ON|OFF
COLUMN^30^     WRA[PPED] | WOR[D_WRAPPED] | TRU[NCATED]
COLUMN^31^ 
COLUMN^32^ For detailed information on this command, see the SQL*Plus User's 
COLUMN^33^ Guide and Reference.
COLUMN^34^ 
COMPUTE^1^ 
COMPUTE^2^ COMPUTE
COMPUTE^3^ -------
COMPUTE^4^ 
COMPUTE^5^ COMPUTE calculates and prints summary lines, using various standard
COMPUTE^6^ computations, on subsets of selected rows. It also lists all 
COMPUTE^7^ COMPUTE definitions.
COMPUTE^8^ 
COMPUTE^9^ COMP[UTE] [function [LAB[EL] text] ...
COMPUTE^10^     OF {quoted_select_expr|column|alias} ...
COMPUTE^11^     ON {quoted_select_expr|column|alias|REPORT|ROW} ...]
COMPUTE^12^ 
COMPUTE^13^ For detailed information on this command, see the SQL*Plus User's 
COMPUTE^14^ Guide and Reference.
COMPUTE^15^ 
CONNECT^1^ 
CONNECT^2^ CONNECT
CONNECT^3^ -------
CONNECT^4^ 
CONNECT^5^ CONNECT establishes a connection to an Oracle database.
CONNECT^6^ 
CONNECT^7^ CONN[ECT] username[/password][@database_specification]|/
CONNECT^8^ 
CONNECT^9^ For detailed information on this command, see the SQL*Plus User's 
CONNECT^10^ Guide and Reference.
CONNECT^11^ 
COPY^1^ 
COPY^2^ COPY
COPY^3^ ----
COPY^4^ 
COPY^5^ COPY copies data from a query to a table in a local or remote 
COPY^6^ database.
COPY^7^ 
COPY^8^ COPY [FROM username [/password] [@database_specification]|
COPY^9^       TO username [/password] [@database_specification]]
COPY^10^       {APPEND|CREATE|INSERT|REPLACE} destination_table
COPY^11^       [(column, column, column, ...)] USING query
COPY^12^ 
COPY^13^ For detailed information on this command, see the SQL*Plus User's 
COPY^14^ Guide and Reference.
COPY^15^ 
DBA^1^ 
DBA^2^ DBA
DBA^3^ ---
DBA^4^ 
DBA^5^ DBA username SYSTEM owns and has all privileges on 
DBA^6^ PRODUCT_USER_PROFILE.
DBA^7^ Other users should have only SELECT access to this table. Command 
DBA^8^ file PUPBLD, when run, grants SELECT access on PRODUCT_USER_PROFILE 
DBA^9^ to PUBLIC.
DBA^10^ 
DBA^11^ For detailed information on this command, see the SQL*Plus User's 
DBA^12^ Guide and Reference.
DBA^13^ 
DEFINE^1^ 
DEFINE^2^ DEFINE
DEFINE^3^ ------
DEFINE^4^ 
DEFINE^5^ DEFINE specifies a user variable and assigns it a CHAR value, or 
DEFINE^6^ lists the value and variable type of a single variable or all 
DEFINE^7^ variables.
DEFINE^8^ 
DEFINE^9^ DEF[INE] [variable]|[variable = text]
DEFINE^10^ 
DEFINE^11^ For detailed information on this command, see the SQL*Plus User's 
DEFINE^12^ Guide and Reference.
DEFINE^13^ 
DEL^1^ 
DEL^2^ DEL
DEL^3^ ---
DEL^4^ 
DEL^5^ DEL deletes one or more lines of the buffer. DEL makes the
DEL^6^ following line of the buffer (if any) the current line. You can
DEL^7^ enter DEL several times to delete several consecutive lines.
DEL^8^ 
DEL^9^ DEL [n|n m|n *|n LAST|*|* n|* LAST|LAST]
DEL^10^ 
DEL^11^ For detailed information on this command, see the SQL*Plus User's 
DEL^12^ Guide and Reference.
DEL^13^ 
DESCRIBE^1^ 
DESCRIBE^2^ DESCRIBE
DESCRIBE^3^ --------
DESCRIBE^4^ 
DESCRIBE^5^ DESCRIBE lists the column definitions for a table, view, or synonym,
DESCRIBE^6^ or the specifications for a function or procedure.
DESCRIBE^7^ 
DESCRIBE^8^ DESC[RIBE] [schema.]object[@database_link_name] 
DESCRIBE^9^ 
DESCRIBE^10^ For detailed information on this command, see the SQL*Plus User's 
DESCRIBE^11^ Guide and Reference.
DESCRIBE^12^ 
DISCONNECT^1^ 
DISCONNECT^2^ DISCONNECT
DISCONNECT^3^ ----------
DISCONNECT^4^ 
DISCONNECT^5^ DISCONNECT commits pending changes to the database and logs the 
DISCONNECT^6^ current user out of Oracle, but does not exit SQL*Plus. Use EXIT or 
DISCONNECT^7^ QUIT to log out of Oracle and return control to your host computer's 
DISCONNECT^8^ operating system.
DISCONNECT^9^ 
DISCONNECT^10^ DISC[ONNECT]
DISCONNECT^11^ 
DISCONNECT^12^ For detailed information on this command, see the SQL*Plus User's 
DISCONNECT^13^ Guide and Reference.
DISCONNECT^14^ 
EDIT^1^ 
EDIT^2^ EDIT
EDIT^3^ ----
EDIT^4^
EDIT^5^ EDIT invokes a host operating system text editor on the contents of 
EDIT^6^ the specified file or on the contents of the buffer.
EDIT^7^
EDIT^8^ ED[IT] [file_name[.ext]]
EDIT^9^ 
EDIT^10^ For detailed information on this command, see the SQL*Plus User's 
EDIT^11^ Guide and Reference.
EDIT^12^ 
EXECUTE^1^ 
EXECUTE^2^ EXECUTE
EXECUTE^3^ -------
EXECUTE^4^ 
EXECUTE^5^ EXECUTE executes a single PL/SQL statement. The EXECUTE command is
EXECUTE^6^ often useful when you want to execute a PL/SQL statement that
EXECUTE^7^ references a stored procedure.
EXECUTE^8^ 
EXECUTE^9^ EXEC[UTE] statement
EXECUTE^10^ 
EXECUTE^11^ For detailed information on this command, see the SQL*Plus User's 
EXECUTE^12^ Guide and Reference.
EXECUTE^13^ 
EXIT^1^ 
EXIT^2^ EXIT
EXIT^3^ ----
EXIT^4^ 
EXIT^5^ EXIT terminates SQL*Plus, and returns control to the operating 
EXIT^6^ system.
EXIT^7^ 
EXIT^8^ {EXIT|QUIT} [SUCCESS|FAILURE|WARNING|n|variable|:BindVariable]
EXIT^9^    [COMMIT|ROLLBACK]
EXIT^10^ 
EXIT^11^ For detailed information on this command, see the SQL*Plus User's 
EXIT^12^ Guide and Reference.
EXIT^13^ 
GET^1^ 
GET^2^ GET
GET^3^ ---
GET^4^ 
GET^5^ GET loads a host operating system file into the SQL buffer.
GET^6^ 
GET^7^ GET file_name[.ext] [LIS[T]|NOL[IST]]
GET^8^ 
GET^9^ For detailed information on this command, see the SQL*Plus User's 
GET^10^ Guide and Reference.
GET^11^ 
HELP^1^ 
HELP^2^ HELP
HELP^3^ ----
HELP^4^ 
HELP^5^ HELP displays information on the commands and conventions of 
HELP^6^ SQL*Plus, SQL, and PL/SQL. Type "help", a space, all or part of any 
HELP^7^ topic, and then press Enter.
HELP^8^ 
HELP^9^ HELP [topic] | help
HELP^10^ 
HELP^11^ For detailed information on this command, see the SQL*Plus User's 
HELP^12^ Guide and Reference.
HELP^13^ 
HOST^1^ 
HOST^2^ HOST
HOST^3^ ----
HOST^4^ 
HOST^5^ HOST executes a host operating system command without leaving 
HOST^6^ SQL*Plus.
HOST^7^ 
HOST^8^ HO[ST] [ command ]
HOST^9^ 
HOST^10^ For detailed information on this command, see the SQL*Plus User's 
HOST^11^ Guide and Reference.
HOST^12^ 
INDEX^1^ 
INDEX^2^ Use the HELP TOPIC command for a list of help topics.
INDEX^3^  
INPUT^1^ 
INPUT^2^ INPUT
INPUT^3^ -----
INPUT^4^ 
INPUT^5^ INPUT adds one or more lines of text after the current line in the 
INPUT^6^ buffer.
INPUT^7^ 
INPUT^8^ I[NPUT] [ text ]
INPUT^9^ 
INPUT^10^ For detailed information on this command, see the SQL*Plus User's 
INPUT^11^ Guide and Reference.
INPUT^12^ 
LIST^1^ 
LIST^2^ LIST
LIST^3^ ----
LIST^4^ 
LIST^5^ LIST displays one or more lines of the SQL buffer. Enter LIST by
LIST^6^ itself to list all lines.
LIST^7^ 
LIST^8^     Clause    Lists
LIST^9^     -----------------------------------------
LIST^10^     n         line n.
LIST^11^     n m       lines n through m.
LIST^12^     n *       line n through the current line.
LIST^13^     n LAST    line n through the last line.
LIST^14^     *         the current line.
LIST^15^     * n       the current line through line n.
LIST^16^     * LAST    the current line through the last line.
LIST^17^     LAST      the last line.
LIST^18^ 
LIST^19^ The last line listed is the new current line (with an asterisk).
LIST^20^
LIST^21^ L[IST] [n|n m|n  *|n LAST|*|* n|* LAST|LAST]
LIST^22^ 
LIST^23^ For detailed information on this command, see the SQL*Plus User's 
LIST^24^ Guide and Reference.
LIST^25^ 
MENU^1^ 
MENU^2^ Menu
MENU^3^ ----
MENU^4^ 
MENU^5^ Enter TOPIC for a list of help topics.
MENU^6^ 
MENU^7^ For detailed information on this command, see the SQL*Plus User's 
MENU^8^ Guide and Reference.
MENU^9^ 
PASSWORD^1^ 
PASSWORD^2^ PASSWORD
PASSWORD^3^ --------
PASSWORD^4^ 
PASSWORD^5^ PASSWORD allows you to change passwords without echoing the password 
PASSWORD^6^ on an input device.
PASSWORD^7^ 
PASSWORD^8^ PASSW[ORD] [username]
PASSWORD^9^ 
PASSWORD^10^ For detailed information on this command, see the SQL*Plus User's 
PASSWORD^11^ Guide and Reference.
PASSWORD^12^ 
PAUSE^1^ 
PAUSE^2^ PAUSE
PAUSE^3^ -----
PAUSE^4^ 
PAUSE^5^ PAUSE displays an empty line followed by a line with text, then 
PAUSE^6^ waits for the user to press RETURN. Or it displays two empty lines, 
PAUSE^7^ and waits for the user's response.
PAUSE^8^ 
PAUSE^9^ PAU[SE] [text]
PAUSE^10^ 
PAUSE^11^ For detailed information on this command, see the SQL*Plus User's 
PAUSE^12^ Guide and Reference.
PAUSE^13^ 
PRINT^1^ 
PRINT^2^ PRINT
PRINT^3^ -----
PRINT^4^ 
PRINT^5^ PRINT displays the current values of bind variables.
PRINT^6^ 
PRINT^7^ PRI[NT] [variable ...]
PRINT^8^ 
PRINT^9^ For detailed information on this command, see the SQL*Plus User's 
PRINT^10^ Guide and Reference.
PRINT^11^ 
PROMPT^1^ 
PROMPT^2^ PROMPT
PROMPT^3^ ------
PROMPT^4^ 
PROMPT^5^ PROMPT sends the specified message or a blank line to the user's 
PROMPT^6^ screen.
PROMPT^7^ 
PROMPT^8^ PROMPT [text]
PROMPT^9^ 
PROMPT^10^ For detailed information on this command, see the SQL*Plus User's 
PROMPT^11^ Guide and Reference.
PROMPT^12^ 
QUIT^1^ 
QUIT^2^ QUIT
QUIT^3^ ----
QUIT^4^ 
QUIT^5^ QUIT commits all pending database changes, leaves SQL*Plus, and 
QUIT^6^ returns control to the operating system.
QUIT^7^ 
QUIT^8^ {QUIT|EXIT} [SUCCESS|FAILURE|WARNING|n|variable|:BindVariable]
QUIT^9^     [COMMIT|ROLLBACK]
QUIT^10^ 
QUIT^11^ For detailed information on this command, see the SQL*Plus User's 
QUIT^12^ Guide and Reference.
QUIT^13^ 
REMARK^1^ 
REMARK^2^ REMARK
REMARK^3^ ------
REMARK^4^ 
REMARK^5^ REMARK at the beginning of a line signifies a comment in a command 
REMARK^6^ file.
REMARK^7^ 
REMARK^8^ The comment ends at the end of the line. A line cannot contain both 
REMARK^9^ a comment and a command. See /* for information on entering 
REMARK^10^ comments in statements.
REMARK^11^
REMARK^12^ REM[ARK]
REMARK^13^ 
REMARK^14^ For detailed information on this command, see the SQL*Plus User's 
REMARK^15^ Guide and Reference.
REMARK^16^ 
REPFOOTER^1^ 
REPFOOTER^2^ REPFOOTER
REPFOOTER^3^ ---------
REPFOOTER^4^ 
REPFOOTER^5^ Places and formats a footer at the bottom of a report, or lists the
REPFOOTER^6^ REPFOOTER definition.
REPFOOTER^7^ 
REPFOOTER^8^ REPF[OOTER] [PAGE] [printspec [text|variable] ...] | [OFF|ON]
REPFOOTER^9^ 
REPFOOTER^10^ For detailed information on this command, see the SQL*Plus User's 
REPFOOTER^11^ Guide and Reference.
REPFOOTER^12^ 
REPHEADER^1^ 
REPHEADER^2^ REPHEADER
REPHEADER^3^ ---------
REPHEADER^4^ 
REPHEADER^5^ Places and formats a header at the top of a report, or lists the
REPHEADER^6^ REPHEADER definition.
REPHEADER^7^ 
REPHEADER^8^ REPH[EADER] [PAGE] [printspec [text|variable] ...] | [OFF|ON]
REPHEADER^9^ 
REPHEADER^10^ where printspec is one or more of the clauses:
REPHEADER^11^ 
REPHEADER^12^         COL n          LE[FT]        BOLD
REPHEADER^13^         S[KIP] [n]     CE[NTER]      FORMAT text
REPHEADER^14^         TAB n          R[IGHT]
REPHEADER^15^ 
REPHEADER^16^ For detailed information on this command, see the SQL*Plus User's 
REPHEADER^17^ Guide and Reference.
REPHEADER^18^ 
RESERVED WORDS^1^ 
RESERVED WORDS^2^ Reserved Words
RESERVED WORDS^3^ --------------
RESERVED WORDS^4^ 
RESERVED WORDS^5^ The following words have special meaning in SQL and PL/SQL, and may
RESERVED WORDS^6^ not be used for identifier names (unless enclosed in "quotes"):
RESERVED WORDS^7^ 
RESERVED WORDS^8^ ABORT      AUDIT           CLUSTERS     DATA_BASE      DISPOSE
RESERVED WORDS^9^ ACCEPT     AUTHORIZATION   COLAUTH      DATE           DISTINCT
RESERVED WORDS^10^ ACCESS     AVG             COLUMN       DBA            DO
RESERVED WORDS^11^ ADD        BEGIN           COMMENT      DEBUGOFF       DROP
RESERVED WORDS^12^ ALL        BETWEEN         COMMIT       DEBUGON        ELSE
RESERVED WORDS^13^ ALTER      BODY            COMPRESS     DECIMAL        ELSIF
RESERVED WORDS^14^ AND        BOOLEAN         CONNECT      DECLARE        END
RESERVED WORDS^15^ ANY        BY              CONSTANT     DEFAULT        ENTRY
RESERVED WORDS^16^ ARRAY      CASE            COUNT        DEFINITION     EXCEPTION
RESERVED WORDS^17^ AS         CHAR            CRASH        DELAY          EXCEPTION_INIT
RESERVED WORDS^18^ ASC        CHAR_BASE       CREATE       DELETE         EXCLUSIVE
RESERVED WORDS^19^ ASSERT     CHECK           CURRENT      DELTA          EXISTS
RESERVED WORDS^20^ ASSIGN     CLOSE           CURSOR       DESC           EXIT
RESERVED WORDS^21^ AT         CLUSTER         DATABASE     DIGITS         FALSE
RESERVED WORDS^22^ 
RESERVED WORDS^23^ FETCH        IF            LIKE         NOCOMPRESS     OTHERS
RESERVED WORDS^24^ FILE         IMMEDIATE     LIMITED      NOT            OUT
RESERVED WORDS^25^ FLOAT        IN            LOCK         NOWAIT         PACKAGE
RESERVED WORDS^26^ FOR          INCREMENT     LONG         NULL           PARTITION
RESERVED WORDS^27^ FORM         INDEX         LOOP         NUMBER         PCTFREE
RESERVED WORDS^28^ FROM         INDEXES       MAX          NUMBER_BASE    PRAGMA
RESERVED WORDS^29^ FUNCTION     INDICATOR     MAXEXTENTS   OF             PRIOR
RESERVED WORDS^30^ GENERIC      INITIAL       MIN          OFFLINE        PRIVATE
RESERVED WORDS^31^ GOTO         INSERT        MINUS        ON             PRIVILEGES
RESERVED WORDS^32^ GRANT        INTEGER       MOD          ONLINE         PROCEDURE
RESERVED WORDS^33^ GRAPHIC      INTERSECT     MODE         OPEN           PUBLIC
RESERVED WORDS^34^ GROUP        INTO          MODIFY       OPTION         RAISE
RESERVED WORDS^35^ HAVING       IS            NEW          OR             RANGE
RESERVED WORDS^36^ IDENTIFIED   LEVEL         NOAUDIT      ORDER          RAW
RESERVED WORDS^37^ 
RESERVED WORDS^38^ RECORD       ROWTYPE       SQLERRM      THEN           VARGRAPH
RESERVED WORDS^39^ RELEASE      RUN           START        TO             VARIANCE
RESERVED WORDS^40^ REM          SAVEPOINT     STATEMENT    TRIGGER        VIEW
RESERVED WORDS^41^ REMARK       SCHEMA        STDDEV       TRUE           VIEWS
RESERVED WORDS^42^ RENAME       SELECT        SUBTYPE      TYPE           WHEN
RESERVED WORDS^43^ RESOURCE     SEPARATE      SUCCESSFUL   UID            WHENEVER
RESERVED WORDS^44^ RETURN       SESSION       SUM          UNION          WHERE
RESERVED WORDS^45^ REVERSE      SET           SYNONYM      UNIQUE         WHILE
RESERVED WORDS^46^ REVOKE       SHARE         SYSDATE      UPDATE         WITH
RESERVED WORDS^47^ ROLLBACK     SIZE          TABAUTH      USE            WORK
RESERVED WORDS^48^ ROW          SMALLINT      TABLE        USER           XOR
RESERVED WORDS^49^ ROWID        SPACE         TABLES       VALIDATE
RESERVED WORDS^50^ ROWNUM       SQL           TASK         VALUES
RESERVED WORDS^51^ ROWS         SQLCODE       TERMINATE    VARCHAR
RESERVED WORDS^52^ 
RUN^1^ 
RUN^2^ RUN
RUN^3^ ---
RUN^4^ 
RUN^5^ RUN lists and executes the SQL command or PL/SQL block currently in 
RUN^6^ the SQL buffer. RUN makes the last line of the SQL buffer the 
RUN^7^ current line.
RUN^8^ 
RUN^9^ The slash command (/) works like RUN, but doesn't list the command.
RUN^10^ 
RUN^11^ R[UN]
RUN^12^ 
RUN^13^ For detailed information on this command, see the SQL*Plus User's 
RUN^14^ Guide and Reference.
RUN^15^ 
SAVE^1^ 
SAVE^2^ SAVE
SAVE^3^ ----
SAVE^4^ 
SAVE^5^ SAVE stores the SQL buffer's contents in a host operating system 
SAVE^6^ command file.
SAVE^7^ 
SAVE^8^ SAV[E] file_name[.ext] [CRE[ATE]|REP[LACE]|APP[END]]
SAVE^9^ 
SAVE^10^ For detailed information on this command, see the SQL*Plus User's 
SAVE^11^ Guide and Reference.
SAVE^12^ 
SET^1^ 
SET^2^ SET
SET^3^ ---
SET^4^ 
SET^5^ Use SET to control SQL*Plus environment settings for the current 
SET^6^ session; for example:
SET^7^                -   the display width for NUMBER data
SET^8^                -   the display width for LONG data
SET^9^                -   enabling or disabling the printing of column 
SET^10^                    headings
SET^11^                -   the number of lines per page
SET^12^ 
SET^13^ 
SET^14^ SET system_variable value
SET^15^ 
SET^16^   APPI[NFO]{ON|OFF|text}                   NULL text
SET^17^   ARRAY[SIZE] {20|n}                       NUMF[ORMAT] format
SET^18^   AUTO[COMMIT] {OFF|ON|IMM[EDIATE|n]}      NUM[WIDTH] {10|n}
SET^19^   AUTOP[RINT] {OFF|ON}                     PAGES[IZE] {24|n}
SET^20^   AUTOT[RACE] {OFF|ON|TRACE[ONLY]}         PAU[SE] {OFF|ON|text}
SET^21^    [EXP[LAIN]] [STAT[ISTICS]]              RECSEP {WR[APPED]|
SET^22^                                             EA[CH]|OFF}
SET^23^   BLO[CKTERMINATOR] {.|c}                  RECSEPCHAR { |c}
SET^24^   CMDS[EP] {;|c|OFF|ON}                    SEVEROUT[PUT] {OFF|ON} 
SET^25^                                             [SIZE n] [FOR[MAT] 
SET^26^   COLSEP { |text}                           {WRA[PPED]| 
SET^27^                                             WOR[D_WRAPPED]|
SET^28^   COM[PATIBILITY] {V7|V8|NATIVE}            TRU[NCATED]}]
SET^29^   CON[CAT] {.|c|OFF|ON}                    SHIFT[INOUT] {VIS[IBLE]|
SET^30^                                             INV[ISIBLE]}
SET^31^   COPYC[OMMIT] {0|n}                       SHOW[MODE] {OFF|ON}  
SET^32^   COPYTYPECHECK {OFF|ON}                   SQLC[ASE] {MIX[ED]|
SET^33^                                             LO[WER]|UP[PER]}
SET^34^   DEF[INE] {&|c|OFF|ON}                    SQLCO[NTINUE] {> | text}
SET^35^   ECHO {OFF|ON}                            SQLN[UMBER] {OFF|ON}
SET^36^   EDITF[ILE] file_name[.ext]               SQLPRE[FIX] {#|c}
SET^37^   EMB[EDEDDED] {OFF|ON}                    SQLP[ROMPT] {SQL>|text}
SET^38^   ESC[APE] {\|c|OFF|ON}                    SQLT[ERMINATOR]
SET^39^                                             {;|c|OFF|ON}
SET^40^   FEED[BACK] {6|n|OFF|ON}                  SUF[FIX] {SQL|text}
SET^41^   FLAGGER {OFF|ENTRY|INTERMED[IATE]|FULL}  TAB {OFF|ON}
SET^42^   FLU[SH] {OFF|ON}                         TERM[OUT] {OFF|ON}
SET^43^   HEA[DING] {OFF|ON}                       TI[ME] {OFF|ON}
SET^44^   HEADS[EP] {||c|OFF|ON}                   TIMI[NG] {OFF|ON}
SET^45^   LIN[ESIZE] {80|n}                        TRIM[OUT] {OFF|ON}
SET^46^   LOBOFFSET {n|1}                          TRIMS[POOL] {ON|OFF}
SET^47^   LONG {80|n}                              UND[ERLINE] {-|c|ON|OFF}
SET^48^   LONGC[HUNKSIZE] {80|n}                   VER[IFY] {OFF|ON}
SET^49^   NEWP[AGE] {1|n|NONE}                     WRA[P] {OFF|ON}
SET^50^                              
SET^51^ For detailed information on this command, see the SQL*Plus User's 
SET^52^ Guide and Reference.
SET^53^ 
SHOW^1^ 
SHOW^2^ SHOW
SHOW^3^ ----
SHOW^4^ 
SHOW^5^ Use SHOW to show the value of a SQL*Plus system variable, or the
SHOW^6^ current SQL*Plus environment.
SHOW^7^ 
SHOW^8^ SHO[W] option
SHOW^9^ 
SHOW^10^     where option can be:
SHOW^11^ 
SHOW^12^     system_variable
SHOW^13^     ALL
SHOW^14^     BTI[TLE]
SHOW^15^     ERR[ORS] [{FUNCTION|PROCEDURE|PACKAGE|PACKAGE BODY|TRIGGER|
SHOW^16^        VIEW|TYPE|TYPE BODY} [schema.]name]
SHOW^17^     LABEL
SHOW^18^     LNO
SHOW^19^     PNO
SHOW^20^     REL[EASE]
SHOW^21^     REPF[OOTER]
SHOW^22^     REPH[EADER]
SHOW^23^     SPOO[L]
SHOW^24^     SQLCODE
SHOW^25^     TT[ITLE]
SHOW^26^     USER
SHOW^27^ 
SHOW^28^ For detailed information on this command, see the SQL*Plus User's 
SHOW^29^ Guide and Reference.
SHOW^30^ 
/^1^ 
/^2^ / (slash)
/^3^ ---------
/^4^ 
/^5^ Enter a slash (/) at the command prompt or at a line number prompt 
/^6^ to execute a SQL command or PL/SQL block in the SQL buffer. The 
/^7^ slash command works like RUN, but does not list the command on your 
/^8^ screen buffer.
/^9^ 
/^10^ Executing a SQL command or PL/SQL block with the slash does not 
/^11^ change the current line number in the SQL buffer unless the command 
/^12^ in the buffer has an error. If so, SQL*Plus makes the line with the 
/^13^ error the current line.
/^14^ 
/^15^ /
/^16^ 
/^17^ For detailed information on this command, see the SQL*Plus User's 
/^18^ Guide and Reference.
/^19^ 
SPOOL^1^ 
SPOOL^2^ SPOOL
SPOOL^3^ -----
SPOOL^4^ 
SPOOL^5^ Use SPOOL to store query results in an operating system file, or send the
SPOOL^6^ file to a printer.
SPOOL^7^ 
SPOOL^8^ SPO[OL] [file_name[.ext]|OFF|OUT]
SPOOL^9^ 
SPOOL^10^ For detailed information on this command, see the SQL*Plus User's 
SPOOL^11^ Guide and Reference.
SPOOL^12^ 
STORE^1^ 
STORE^2^ STORE
STORE^3^ -----
STORE^4^ 
STORE^5^ Saves attributes of the current SQL*Plus environment in a host 
STORE^6^ operating system file (a command file).
STORE^7^ 
STORE^8^ STORE {SET} file_name[.ext] [CRE[ATE]|REP[LACE]|APP[END]]
STORE^9^ 
STORE^10^ For detailed information on this command, see the SQL*Plus User's 
STORE^11^ Guide and Reference.
STORE^12^ 
SQLPLUS^1^ 
SQLPLUS^2^ SQLPLUS
SQLPLUS^3^ -------
SQLPLUS^4^ 
SQLPLUS^5^ SQLPLUS starts SQL*Plus from the operating system prompt. Start 
SQLPLUS^6^ enables you to enter a command filename and arguments. SQL*Plus 
SQLPLUS^7^ passes the arguments to the command file as though you executed the 
SQLPLUS^8^ file with the SQL*Plus START command.
SQLPLUS^9^ 
SQLPLUS^10^ If you omit logon and specify start, SQL*Plus assumes that the first 
SQLPLUS^11^ line of the command file contains a valid logon. If both start and 
SQLPLUS^12^ logon are omitted, SQL*Plus prompts for logon information.
SQLPLUS^13^ 
SQLPLUS^14^ SQLPLUS [[-S[ILENT]] [logon] [start]]|-|-?
SQLPLUS^15^ 
SQLPLUS^16^     logon:  username[/password][@database_specification]|/|/NOLOG
SQLPLUS^17^     start:  @file_name[.ext ] [arg ...]
SQLPLUS^18^ 
SQLPLUS^19^ For detailed information on this command, see the SQL*Plus User's 
SQLPLUS^20^ Guide and Reference.
SQLPLUS^21^ 
START^1^ 
START^2^ START
START^3^ -----
START^4^ 
START^5^ START executes the contents of a command file. The @ ("at" sign) 
START^6^ and @@ (double "at" sign) commands work similarly to the START 
START^7^ command, but do not enable the passing of values to parameters.
START^8^ 
START^9^ STA[RT] file_name[.ext] [arg ...]
START^10^ 
START^11^ For detailed information on this command, see the SQL*Plus User's 
START^12^ Guide and Reference.
START^13^ 
TIMING^1^ 
TIMING^2^ TIMING
TIMING^3^ ------
TIMING^4^ 
TIMING^5^ TIMING records timing data for an elapsed time period, lists the 
TIMING^6^ current timer's name and timing data, or lists the number of active 
TIMING^7^ timers.
TIMING^8^ 
TIMING^9^ TIMI[NG] [START text|SHOW|STOP]
TIMING^10^ 
TIMING^11^ For detailed information on this command, see the SQL*Plus User's 
TIMING^12^ Guide and Reference.
TIMING^13^ 
TTITLE^1^ 
TTITLE^2^ TTITLE
TTITLE^3^ ------
TTITLE^4^ 
TTITLE^5^ TTITLE places and formats a title at the top of each report page. 
TTITLE^6^ Enter TTITLE with no clause to list its current definition. The old 
TTITLE^7^ form of TTITLE is used if only a single word or string in quotes 
TTITLE^8^ follows the TTITLE command.
TTITLE^9^ 
TTITLE^10^ TTI[TLE] [printspec [text|variable] ...] | [OFF|ON]
TTITLE^11^ 
TTITLE^12^ where printspec is one or more of the clauses:
TTITLE^13^ 
TTITLE^14^         COL n          LE[FT]        BOLD
TTITLE^15^         S[KIP] [n]     CE[NTER]      FORMAT text
TTITLE^16^         TAB n          R[IGHT]
TTITLE^17^ 
TTITLE^18^ For detailed information on this command, see the SQL*Plus User's 
TTITLE^19^ Guide and Reference.
TTITLE^20^ 
UNDEFINE^1^ 
UNDEFINE^2^ UNDEFINE
UNDEFINE^3^ --------
UNDEFINE^4^ 
UNDEFINE^5^ UNDEFINE deletes one or more user variables that you defined either
UNDEFINE^6^ explicitly (with the DEFINE command), or implicitly (with a START
UNDEFINE^7^ command argument).
UNDEFINE^8^ 
UNDEFINE^9^ UNDEF[INE] variable ...
UNDEFINE^10^ 
UNDEFINE^11^ For detailed information on this command, see the SQL*Plus User's 
UNDEFINE^12^ Guide and Reference.
UNDEFINE^13^ 
VARIABLE^1^ 
VARIABLE^2^ VARIABLE
VARIABLE^3^ --------
VARIABLE^4^ 
VARIABLE^5^ VARIABLE declares a bind variable that can then be referenced in
VARIABLE^6^ PL/SQL. VARIABLE with no arguments displays a list of all the
VARIABLE^7^ variables declared in the session. VARIABLE followed by a name
VARIABLE^8^ lists that variable.
VARIABLE^9^ 
VARIABLE^10^ VAR[IABLE] [variable [NUMBER|CHAR|CHAR (n)|NCHAR|NCHAR (n)|
VARIABLE^11^    VARCHAR2 (n)|NVARCHAR2 (n)|CLOB|NCLOB|REFCURSOR]]
VARIABLE^12^ 
VARIABLE^13^ For detailed information on this command, see the SQL*Plus User's 
VARIABLE^14^ Guide and Reference.
VARIABLE^15^ 
WHENEVER OSERROR^1^ 
WHENEVER OSERROR^2^ WHENEVER OSERROR
WHENEVER OSERROR^3^ ----------------
WHENEVER OSERROR^4^ 
WHENEVER OSERROR^5^ WHENEVER OSERROR exits SQL*Plus if an operating system error occurs,
WHENEVER OSERROR^6^ (such as a file I/O error).
WHENEVER OSERROR^7^ 
WHENEVER OSERROR^8^ WHENEVER OSERROR {EXIT [SUCCESS|FAILURE|n|variable]
WHENEVER OSERROR^9^    [COMMIT|ROLLBACK]|CONTINUE [COMMIT|ROLLBACK|NONE]}
WHENEVER OSERROR^10^ 
WHENEVER OSERROR^11^ For detailed information on this command, see the SQL*Plus User's 
WHENEVER OSERROR^12^ Guide and Reference.
WHENEVER OSERROR^13^ 
WHENEVER SQLERROR^1^ 
WHENEVER SQLERROR^2^ WHENEVER SQLERROR
WHENEVER SQLERROR^3^ -----------------
WHENEVER SQLERROR^4^ 
WHENEVER SQLERROR^5^ Exits SQL*Plus if a SQL command or PL/SQL block generates an error.
WHENEVER SQLERROR^6^ 
WHENEVER SQLERROR^7^ WHENEVER SQLERROR {EXIT [SUCCESS|FAILURE|WARNING|n|variable]
WHENEVER SQLERROR^8^    [COMMIT|ROLLBACK]|CONTINUE [COMMIT|ROLLBACK|NONE]}
WHENEVER SQLERROR^9^ 
WHENEVER SQLERROR^10^ For detailed information on this command, see the SQL*Plus User's 
WHENEVER SQLERROR^11^ Guide and Reference.
WHENEVER SQLERROR^12^ 
