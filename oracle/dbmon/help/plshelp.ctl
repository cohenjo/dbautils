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
Assignment Statement^1^ 
Assignment Statement^2^ Assignment Statement
Assignment Statement^3^ --------------------
Assignment Statement^4^ 
Assignment Statement^5^ An assignment statement sets the current value of a variable, field, 
Assignment Statement^6^ parameter, or element.
Assignment Statement^7^ 
Assignment Statement^8^ assignment_statement
Assignment Statement^9^   { collection_name
Assignment Statement^10^   | collection_name(index)
Assignment Statement^11^   | cursor_variable_name
Assignment Statement^12^   | :host_cursor_variable_name
Assignment Statement^13^   | :host_variable_name[:indicator_name]
Assignment Statement^14^   | object_name
Assignment Statement^15^   | object_name.attribute_name
Assignment Statement^16^   | parameter_name
Assignment Statement^17^   | record_name
Assignment Statement^18^   | record_name.field_name
Assignment Statement^19^   | variable_name } := expression;
Assignment Statement^20^ 
Assignment Statement^21^ For detailed information on this statement, see the PL/SQL User's Guide and 
Assignment Statement^22^ Reference.
Assignment Statement^23^ 
Blocks^1^
Blocks^2^ Blocks
Blocks^3^ ------
Blocks^4^ 
Blocks^5^ The basic program unit in PL/SQL is the block. A PL/SQL block is defined by 
Blocks^6^ the keywords DECLARE, BEGIN, EXCEPTION, and END. These keywords partition the 
Blocks^7^ PL/SQL block into a declarative part, an executable part, and an exception-
Blocks^8^ handling part. Only the executable part is required.
Blocks^9^ 
Blocks^10^ You can nest a block within another block wherever you can place an executable 
Blocks^11^ statement.
Blocks^12^ 
Blocks^13^ plsql_block
Blocks^14^   [ <<label_name>>]
Blocks^15^   [ DECLARE
Blocks^16^     item_declaration [item_declaration] ...
Blocks^17^     [ subprogram_declaration [subprogram_declaration] ...] ]
Blocks^18^   BEGIN
Blocks^19^     seq_of_statements
Blocks^20^   [ EXCEPTION 
Blocks^21^     exception_handler [exception_handler] ... ]
Blocks^22^   END [label_name];
Blocks^23^ 
Blocks^24^ item_declaration
Blocks^25^   { collection_declaration
Blocks^26^   | constant_declaration
Blocks^27^   | cursor_declaration
Blocks^28^   | cursor_variable_declaration
Blocks^29^   | exception_declaration
Blocks^30^   | object_declaration
Blocks^31^   | record_declaration
Blocks^32^   | variable_declaration }
Blocks^33^ 
Blocks^34^ subprogram_declaration
Blocks^35^   {function_declaration | procedure_declaration}
Blocks^36^ 
Blocks^37^ For detailed information on blocks, see the PL/SQL User's Guide and 
Blocks^38^ Reference.
Blocks^39^ 
CLOSE Statement^1^ 
CLOSE Statement^2^ CLOSE Statement
CLOSE Statement^3^ ---------------
CLOSE Statement^4^ 
CLOSE Statement^5^ The CLOSE statement allows resources held by an open cursor or cursor variable 
CLOSE Statement^6^ to be reused. No more rows can be fetched from a closed cursor or cursor 
CLOSE Statement^7^ variable.
CLOSE Statement^8^ 
CLOSE Statement^9^ close_statement
CLOSE Statement^10^   CLOSE { cursor_name
CLOSE Statement^11^         | cursor_variable_name
CLOSE Statement^12^         | :host_cursor_variable_name };
CLOSE Statement^13^ 
CLOSE Statement^14^ For detailed information on this statement, see the PL/SQL User's Guide and 
CLOSE Statement^15^ Reference.
CLOSE Statement^16^ 
Collection Methods^1^ 
Collection Methods^2^ Collection Methods
Collection Methods^3^ ------------------
Collection Methods^4^ 
Collection Methods^5^ A collection method is a built-in function or procedure that operates on 
Collection Methods^6^ collections and is called using dot notation. The methods EXISTS, COUNT, 
Collection Methods^7^ LIMIT, FIRST, LAST, PRIOR, NEXT, EXTEND, TRIM, and DELETE help generalize 
Collection Methods^8^ code, make collections easier to use, and make your applications easier to 
Collection Methods^9^ maintain.
Collection Methods^10^ 
Collection Methods^11^ EXISTS, COUNT, LIMIT, FIRST, LAST, PRIOR, and NEXT are functions, which appear 
Collection Methods^12^ as part of an expression. EXTEND, TRIM, and DELETE are procedures, which 
Collection Methods^13^ appear as a statement. EXISTS, PRIOR, NEXT, TRIM, EXTEND, and DELETE take 
Collection Methods^14^ integer parameters.
Collection Methods^15^ 
Collection Methods^16^ collection_method_call
Collection Methods^17^   collection_name.{ COUNT
Collection Methods^18^                   | DELETE[ (index[, index] ) ]
Collection Methods^19^                   | EXISTS(index)
Collection Methods^20^                   | EXTEND[ (number, index) ]
Collection Methods^21^                   | FIRST
Collection Methods^22^                   | LAST
Collection Methods^23^                   | LIMIT
Collection Methods^24^                   | NEXT(index)
Collection Methods^25^                   | PRIOR(index)
Collection Methods^26^                   | TRIM[(index)] }
Collection Methods^27^ 
Collection Methods^28^ For detailed information on collection methods, see the PL/SQL User's Guide 
Collection Methods^29^ and Reference.
Collection Methods^30^ 
Collections^1^ 
Collections^2^ Collections
Collections^3^ -----------
Collections^4^ 
Collections^5^ The collection types TABLE and VARRAY allow you to declare nested tables and 
Collections^6^ variable-size arrays (varrays for short). Nested tables are modeled as 
Collections^7^ database tables with a primary key. The primary key gives you array-like 
Collections^8^ access to rows.
Collections^9^ 
Collections^10^ Like an array, a nested table is an ordered collection of elements of the same 
Collections^11^ type. Each element has a unique index number that determines its position in 
Collections^12^ the ordered collection. But, unlike an array, a nested table is unbounded. So, 
Collections^13^ its size can increase dynamically. Also, it does not require consecutive index 
Collections^14^ numbers. So, it can be indexed by any series of integers.
Collections^15^ 
Collections^16^ Varrays work like the arrays found in most third-generation languages. Varrays 
Collections^17^ let you associate a single identifier with an entire collection. This 
Collections^18^ association lets you manipulate the collection as a whole and reference 
Collections^19^ individual elements easily. To reference an element, you use standard 
Collections^20^ subscripting syntax. Unlike nested tables, varrays have a maximum size, which 
Collections^21^ you must specify.
Collections^22^ 
Collections^23^ To create collections, you define a collection type (TABLE or VARRAY), then 
Collections^24^ declare collections of that type.
Collections^25^ 
Collections^26^ table_type_definition
Collections^27^   TYPE table_type_name IS TABLE OF element_type [NOT NULL]
Collections^28^     INDEX BY BINARY_INTEGER;
Collections^29^ 
Collections^30^ varray_type_definition 
Collections^31^   TYPE varray_type_name IS {VARRAY | VARRYING ARRAY}(size_limit) [NOT NULL] 
Collections^32^     OF element_type;
Collections^33^ 
Collections^34^ collection_declaration 
Collections^35^   collection_name {table_type_name | varray_type_name};
Collections^36^ 
Collections^37^ For detailed information on collections, see the PL/SQL User's Guide and 
Collections^38^ Reference.
Collections^39^ 
Comments^1^ 
Comments^2^ Comments
Comments^3^ --------
Comments^4^ 
Comments^5^ Comments describe the purpose and use of code segments and so promote 
Comments^6^ readability. PL/SQL supports two comment styles: single-line and multi-line. 
Comments^7^ Single-line comments begin with a double hyphen (- -) anywhere on a line and 
Comments^8^ extend to the end of the line. Multi-line comments begin with a slash-asterisk 
Comments^9^ (/*), end with an asterisk-slash (*/), and can span multiple lines.
Comments^10^ 
Comments^11^ comment 
Comments^12^   {-- text | /* text */}
Comments^13^ 
Comments^14^ For detailed information on this statement, see the PL/SQL User's Guide and 
Comments^15^ Reference.
Comments^16^ 
Comments^17^ For detailed information on comments, see the PL/SQL User's Guide and 
Comments^18^ Reference.
Comments^19^ 
COMMIT Statement^1^ 
COMMIT Statement^2^ COMMIT Statement
COMMIT Statement^3^ ----------------
COMMIT Statement^4^ 
COMMIT Statement^5^ The COMMIT statement explicitly makes permanent any changes made to the 
COMMIT Statement^6^ database during the current transaction. Changes made to the database are not 
COMMIT Statement^7^ considered permanent until they are committed. A commit also makes the changes 
COMMIT Statement^8^ visible to other users.
COMMIT Statement^9^ 
COMMIT Statement^10^ commit_statement 
COMMIT Statement^11^   COMMIT [WORK] [COMMENT 'text'];
COMMIT Statement^12^ 
COMMIT Statement^13^ For detailed information on this statement, see the PL/SQL User's Guide and 
COMMIT Statement^14^ Reference.
COMMIT Statement^15^ 
Constants and Variables^1^ 
Constants and Variables^2^ Constants and Variables
Constants and Variables^3^ -----------------------
Constants and Variables^4^ 
Constants and Variables^5^ You can declare constants and variables in the declarative part of any PL/SQL 
Constants and Variables^6^ block, subprogram, or package. Declarations allocate storage space for a 
Constants and Variables^7^ value, specify its datatype, and name the storage location so that you can 
Constants and Variables^8^ reference it. Declarations can also assign an initial value and impose the NOT 
Constants and Variables^9^ NULL constraint.
Constants and Variables^10^ 
Constants and Variables^11^ constant_declaration  
Constants and Variables^12^   constant_name CONSTANT 
Constants and Variables^13^     { record_name.field_name%TYPE
Constants and Variables^14^     | scalar_type_name
Constants and Variables^15^     | table_name.column_name%TYPE
Constants and Variables^16^     | variable_name%TYPE}
Constants and Variables^17^     [NOT NULL] {:= | DEFAULT} expression;
Constants and Variables^18^ 
Constants and Variables^19^ variable_declaration 
Constants and Variables^20^   variable_name 
Constants and Variables^21^     { collection_name%TYPE
Constants and Variables^22^     | cursor_name%ROWTYPE
Constants and Variables^23^     | cursor_variable_name%TYPE
Constants and Variables^24^     | object_name%TYPE
Constants and Variables^25^     | record_name%TYPE
Constants and Variables^26^     | record_name.field_name%TYPE
Constants and Variables^27^     | scalar_type_name
Constants and Variables^28^     | table_name%ROWTYPE
Constants and Variables^29^     | table_name.column_name%TYPE
Constants and Variables^30^     | variable_name%TYPE }
Constants and Variables^31^     [[NOT NULL] {:= | DEFAULT} expression];
Constants and Variables^32^ 
Constants and Variables^33^ For detailed information on constants and variables, see the PL/SQL User's 
Constants and Variables^34^ Guide and Reference.
Constants and Variables^35^ 
Cursor Attributes^1^ 
Cursor Attributes^2^ Cursor Attributes
Cursor Attributes^3^ -----------------
Cursor Attributes^4^ 
Cursor Attributes^5^ Cursors and cursor variables have four attributes that give you useful 
Cursor Attributes^6^ information about the execution of a data manipulation statement.
Cursor Attributes^7^ 
Cursor Attributes^8^ There are two kinds of cursors: implicit and explicit. PL/SQL implicitly 
Cursor Attributes^9^ declares a cursor for all SQL data manipulation statements, including single-
Cursor Attributes^10^ row queries. For multi-row queries, you can explicitly declare a cursor or 
Cursor Attributes^11^ cursor variable to process the rows. 
Cursor Attributes^12^ 
Cursor Attributes^13^ cursor_attribute  
Cursor Attributes^14^   { cursor_name 
Cursor Attributes^15^   | cursor_variable_name
Cursor Attributes^16^   | :host_cursor_variable_name
Cursor Attributes^17^   | SQL }
Cursor Attributes^18^   {%FOUND | %ISOPEN | %NOTFOUND | %ROWCOUNT}
Cursor Attributes^19^ 
Cursor Attributes^20^ For detailed information on cursor attributes, see the PL/SQL User's Guide and 
Cursor Attributes^21^ Reference.
Cursor Attributes^22^ 
Cursor Variables^1^ 
Cursor Variables^2^ Cursor Variables
Cursor Variables^3^ ----------------
Cursor Variables^4^ 
Cursor Variables^5^ To execute a multi-row query, Oracle opens an unnamed work area that stores 
Cursor Variables^6^ processing information. To access the information, you can use an explicit 
Cursor Variables^7^ cursor, which names the work area. Or, you can use a cursor variable, which 
Cursor Variables^8^ points to the work area. Whereas a cursor always refers to the same query work 
Cursor Variables^9^ area, a cursor variable can refer to different work areas. Cursor variables 
Cursor Variables^10^ are like C or Pascal pointers, which hold the memory location (address) of 
Cursor Variables^11^ some object instead of the object itself. So, declaring a cursor variable 
Cursor Variables^12^ creates a pointer, not an object.
Cursor Variables^13^ 
Cursor Variables^14^ To create cursor variables, you define a REF CURSOR type, then declare cursor 
Cursor Variables^15^ variables of that type. 
Cursor Variables^16^ 
Cursor Variables^17^ ref_type_definition
Cursor Variables^18^   TYPE ref_type_name IS REF CURSOR
Cursor Variables^19^     RETURN { cursor_name%ROWTYPE
Cursor Variables^20^            | cursor_variable_name%ROWTYPE
Cursor Variables^21^            | record_name%TYPE
Cursor Variables^22^            | record_type_name
Cursor Variables^23^            | table_name%ROWTYPE };
Cursor Variables^24^ 
Cursor Variables^25^ cursor_variable_declaration
Cursor Variables^26^   cursor_variable_name ref_type_name;
Cursor Variables^27^ 
Cursor Variables^28^ For detailed information on cursor variables, see the PL/SQL User's Guide and 
Cursor Variables^29^ Reference.
Cursor Variables^30^ 
Cursors^1^ 
Cursors^2^ Cursors
Cursors^3^ -------
Cursors^4^ 
Cursors^5^ To execute a multi-row query, Oracle opens an unnamed work area that stores 
Cursors^6^ processing information. A cursor lets you name the work area, access the 
Cursors^7^ information, and process the rows individually.
Cursors^8^ 
Cursors^9^ cursor_declaration 
Cursors^10^   CURSOR cursor_name
Cursors^11^     [ (cursor_parameter_declaration[, cursor_parameter_declaration]...) ]
Cursors^12^   IS select_statement;
Cursors^13^ 
Cursors^14^ cursor_specification 
Cursors^15^   CURSOR cursor_name
Cursors^16^     [ (cursor_parameter_declaration[, cursor_parameter_declaration]...) ]
Cursors^17^   RETURN { cursor_name%ROWTYPE
Cursors^18^          | record_name%TYPE
Cursors^19^          | record_type_name
Cursors^20^          | table_name%ROWTYPE };
Cursors^21^ 
Cursors^22^ cursor_body 
Cursors^23^   CURSOR cursor_name
Cursors^24^     [ (cursor_parameter_declaration[, cursor_parameter_declaration]...) ]
Cursors^25^   RETURN { cursor_name%ROWTYPE
Cursors^26^          | record_name%TYPE
Cursors^27^          | record_type_name
Cursors^28^          | table_name%ROWTYPE }
Cursors^29^   IS select_statement;
Cursors^30^ 
Cursors^31^ cursor_parameter_declaration 
Cursors^32^   cursor_parameter_name [IN]
Cursors^33^     { collection_name%TYPE
Cursors^34^     | cursor_name%ROWTYPE
Cursors^35^     | cursor_variable_name%TYPE
Cursors^36^     | object_name%TYPE
Cursors^37^     | record_name%TYPE
Cursors^38^     | scalar_type_name
Cursors^39^     | table_name%ROWTYPE
Cursors^40^     | table_name.column_name%TYPE
Cursors^41^     | variable_name%TYPE }
Cursors^42^     [{:= | DEFAULT} expression]
Cursors^43^ 
Cursors^44^ For detailed information on cursors, see the PL/SQL User's Guide and 
Cursors^45^ Reference.
Cursors^46^ 
DELETE Statement^1^ 
DELETE Statement^2^ DELETE Statement
DELETE Statement^3^ ----------------
DELETE Statement^4^ 
DELETE Statement^5^ The DELETE statement removes entire rows of data from a specified table or 
DELETE Statement^6^ view.
DELETE Statement^7^ 
DELETE Statement^8^ delete_statement
DELETE Statement^9^   DELETE
DELETE Statement^10^     [ FROM] {table_reference | (subquery)} [alias]
DELETE Statement^11^     [ WHERE {search_condition | CURRENT OF cursor_name} ]; 
DELETE Statement^12^ 
DELETE Statement^13^ table_reference
DELETE Statement^14^   [schema_name.]{table_name | view_name}[@dblink_name]
DELETE Statement^15^ 
DELETE Statement^16^ For detailed information on this statement, see the PL/SQL User's Guide and 
DELETE Statement^17^ Reference.
DELETE Statement^18^ 
EXCEPTION_INIT Pragma^1^ 
EXCEPTION_INIT Pragma^2^ EXCEPTION_INIT Pragma
EXCEPTION_INIT Pragma^3^ ---------------------
EXCEPTION_INIT Pragma^4^ 
EXCEPTION_INIT Pragma^5^ The pragma EXCEPTION_INIT associates an exception name with an Oracle error 
EXCEPTION_INIT Pragma^6^ number. That allows you to refer to any internal exception by name and to 
EXCEPTION_INIT Pragma^7^ write a specific handler for it instead of using the OTHERS handler.
EXCEPTION_INIT Pragma^8^ 
EXCEPTION_INIT Pragma^9^ exception_init_pragma  
EXCEPTION_INIT Pragma^10^   PRAGMA EXCEPTION_INIT (exception_name, error_number);
EXCEPTION_INIT Pragma^11^ 
EXCEPTION_INIT Pragma^12^ For detailed information on the EXCEPTION_INIT pragma, see the PL/SQL User's 
EXCEPTION_INIT Pragma^13^ Guide and Reference.
EXCEPTION_INIT Pragma^14^ 
Exceptions^1^ 
Exceptions^2^ Exceptions
Exceptions^3^ ----------
Exceptions^4^ 
Exceptions^5^ An exception is a runtime error or warning condition, which can be predefined 
Exceptions^6^ or user-defined. Predefined exceptions are raised implicitly (automatically) 
Exceptions^7^ by the runtime system. User-defined exceptions must be raised explicitly by 
Exceptions^8^ RAISE statements. To handle raised exceptions, you write separate routines 
Exceptions^9^ called exception handlers.
Exceptions^10^ 
Exceptions^11^ exception_declaration  
Exceptions^12^   exception_name EXCEPTION;
Exceptions^13^ 
Exceptions^14^ exception_handler 
Exceptions^15^   WHEN {exception_name [OR exception_name] ... | OTHERS}
Exceptions^16^   THEN seq_of_statements
Exceptions^17^ 
Exceptions^18^ For detailed information on exceptions, see the PL/SQL User's Guide and 
Exceptions^19^ Reference.
Exceptions^20^ 
EXIT Statement^1^ 
EXIT Statement^2^ EXIT Statement
EXIT Statement^3^ --------------
EXIT Statement^4^ 
EXIT Statement^5^ You use the EXIT statement to exit a loop. The EXIT statement has two forms: 
EXIT Statement^6^ the unconditional EXIT and the conditional EXIT WHEN. With either form, you 
EXIT Statement^7^ can name the loop to be exited.
EXIT Statement^8^ 
EXIT Statement^9^ exit_statement  
EXIT Statement^10^   EXIT [label_name] [WHEN boolean_expression];
EXIT Statement^11^ 
EXIT Statement^12^ For detailed information on this statement, see the PL/SQL User's Guide and 
EXIT Statement^13^ Reference.
EXIT Statement^14^ 
Expressions^1^ 
Expressions^2^ Expressions
Expressions^3^ -----------
Expressions^4^ 
Expressions^5^ An expression is an arbitrarily complex combination of variables, constants, 
Expressions^6^ literals, operators, and function calls. The simplest expression consists of a 
Expressions^7^ single variable.
Expressions^8^ 
Expressions^9^ The PL/SQL compiler determines the datatype of an expression from the types of 
Expressions^10^ the variables, constants, literals, and operators that comprise the 
Expressions^11^ expression. Every time the expression is evaluated, a single value of that 
Expressions^12^ type results. 
Expressions^13^ 
Expressions^14^ expression 
Expressions^15^   [(] { boolean_expression
Expressions^16^       | character_expression
Expressions^17^       | date_expression
Expressions^18^       | numeric_expression } [)]
Expressions^19^ 
Expressions^20^ boolean_expression 
Expressions^21^   [NOT] { boolean_constant_name
Expressions^22^         | boolean_function_call
Expressions^23^         | boolean_literal
Expressions^24^         | boolean_variable_name
Expressions^25^         | other_boolean_form } 
Expressions^26^   [{AND | OR} [NOT] { boolean_constant_name
Expressions^27^                     | boolean_function_call
Expressions^28^                     | boolean_literal
Expressions^29^                     | boolean_variable_name
Expressions^30^                     | other_boolean_form } ] ...
Expressions^31^ 
Expressions^32^ other_boolean_form 
Expressions^33^   expression 
Expressions^34^     { relational_operator expression
Expressions^35^     | collection_name.EXISTS(index)
Expressions^36^     | IS [NOT] NULL
Expressions^37^     | [NOT] LIKE pattern
Expressions^38^     | [NOT] BETWEEN expression AND expression
Expressions^39^     | [NOT] IN (expression[, expression]...)
Expressions^40^     | { cursor_name
Expressions^41^       | cursor_variable_name
Expressions^42^       | :host_cursor_variable_name
Expressions^43^       | SQL}{%FOUND | %ISOPEN | %NOTFOUND} }
Expressions^44^ 
Expressions^45^ numeric_expression 
Expressions^46^   { { cursor_name
Expressions^47^     | cursor_variable_name
Expressions^48^     | :host_cursor_variable_name
Expressions^49^     | SQL } %ROWCOUNT
Expressions^50^   | :host_variable_name[:indicator_name]
Expressions^51^   | numeric_constant_name
Expressions^52^   | numeric_function_call
Expressions^53^   | numeric_literal
Expressions^54^   | numeric_variable_name
Expressions^55^   | collection_name.{ COUNT
Expressions^56^                     | FIRST
Expressions^57^                     | LAST
Expressions^58^                     | LIMIT
Expressions^59^                     | NEXT(index)
Expressions^60^                     | PRIOR(index) } } [**exponent]
Expressions^61^   [ {+ | - | * | /}
Expressions^62^       { { cursor_name
Expressions^63^         | cursor_variable_name
Expressions^64^         | :host_cursor_variable_name
Expressions^65^         | SQL } %ROWCOUNT
Expressions^66^       | :host_variable_name[:indicator_name]
Expressions^67^       | numeric_constant_name
Expressions^68^       | numeric_function_call
Expressions^69^       | numeric_literal
Expressions^70^       | numeric_variable_name
Expressions^71^       | collection_name.{ COUNT
Expressions^72^                         | FIRST
Expressions^73^                         | LAST
Expressions^74^                         | LIMIT
Expressions^75^                         | NEXT(index)
Expressions^76^                         | PRIOR(index) } } [**exponent] ]...
Expressions^77^ 
Expressions^78^ character_expression 
Expressions^79^   { character_constant_name
Expressions^80^   | character_function_call
Expressions^81^   | character_literal
Expressions^82^   | character_variable_name
Expressions^83^   | :host_variable_name[:indicator_name] }
Expressions^84^   [ || { character_constant_name
Expressions^85^        | character_function_call
Expressions^86^        | character_literal
Expressions^87^        | character_variable_name
Expressions^88^        | :host_variable_name[:indicator_name] } ]...
Expressions^89^ 
Expressions^90^ date_expression 
Expressions^91^   { date_constant_name
Expressions^92^   | date_function_call
Expressions^93^   | date_literal
Expressions^94^   | date_variable_name
Expressions^95^   | :host_variable_name[:indicator_name] }
Expressions^96^   [ {+ | -} numeric_expression]...
Expressions^97^ 
Expressions^98^ For detailed information on expressions, see the PL/SQL User's Guide and 
Expressions^99^ Reference.
Expressions^100^ 
External Procedures^1^ 
External Procedures^2^ External Procedures
External Procedures^3^ -------------------
External Procedures^4^ 
External Procedures^5^ An external procedure is a third-generation language (3GL) routine stored in a 
External Procedures^6^ shared library, registered with PL/SQL, and called by you to do special- 
External Procedures^7^ purpose processing. At run time, PL/SQL loads the library dynamically, then 
External Procedures^8^ calls the routine as if it were a PL/SQL function or procedure. To safeguard 
External Procedures^9^ your database, the routine runs in a separate address space. 
External Procedures^10^ 
External Procedures^11^ A shared library is an operating-system file (a Windows DLL for example) that 
External Procedures^12^ stores external procedures. For safety and security, your DBA controls access 
External Procedures^13^ to the library. Using the CREATE LIBRARY statement, the DBA creates a schema 
External Procedures^14^ object called an alias library, which represents the shared library. Then, if 
External Procedures^15^ you are an authorized user, the DBA grants you EXECUTE privileges on the alias 
External Procedures^16^ library. After registering the external procedures, you can call them from any 
External Procedures^17^ PL/SQL program. 
External Procedures^18^ 
External Procedures^19^ external_clause 
External Procedures^20^   EXTERNAL LIBRARY library_name 
External Procedures^21^   [NAME external_procedure_name]
External Procedures^22^   [LANGUAGE language_name] 
External Procedures^23^   [CALLING_STANDARD {C | PASCAL}]
External Procedures^24^   [WITH_CONTEXT] 
External Procedures^25^   [PARAMETERS (external_parameter_list)];
External Procedures^26^ 
External Procedures^27^ external_parameter_list
External Procedures^28^   { {parameter_name [property] | RETURN property} 
External Procedures^29^     [BY_REF] [external_type]
External Procedures^30^     [, {parameter_name [property] | RETURN property} 
External Procedures^31^        [BY_REF] [external_type] ]...
External Procedures^32^     | CONTEXT }
External Procedures^33^ 
External Procedures^34^ property 
External Procedures^35^   {INDICATOR | LENGTH | MAXLEN | CHARSETID | CHARSETFORM}
External Procedures^36^ 
External Procedures^37^ For detailed information on external procedures, see the PL/SQL User's Guide 
External Procedures^38^ and Reference.
External Procedures^39^ 
FETCH Statement^1^ 
FETCH Statement^2^ FETCH Statement
FETCH Statement^3^ ---------------
FETCH Statement^4^ 
FETCH Statement^5^ The FETCH statement retrieves rows of data one at a time from the result set 
FETCH Statement^6^ of a multi-row query. The data is stored in variables or fields that 
FETCH Statement^7^ correspond to the columns selected by the query.
FETCH Statement^8^ 
FETCH Statement^9^ fetch_statement  
FETCH Statement^10^   FETCH { cursor_name 
FETCH Statement^11^         | cursor_variable_name
FETCH Statement^12^         | :host_cursor_variable_name }
FETCH Statement^13^   INTO {variable_name[, variable_name]... | record_name};
FETCH Statement^14^ 
FETCH Statement^15^ For detailed information on this statement, see the PL/SQL User's Guide and 
FETCH Statement^16^ Reference.
FETCH Statement^17^ 
Functions^1^ 
Functions^2^ Functions
Functions^3^ ---------
Functions^4^ 
Functions^5^ A function is a named program unit that takes parameters and returns a 
Functions^6^ computed value.
Functions^7^ 
Functions^8^ A function has two parts: the specification and the body. The function 
Functions^9^ specification begins with the keyword FUNCTION and ends with the RETURN 
Functions^10^ clause, which specifies the datatype of the result value. Parameter 
Functions^11^ declarations are optional. Functions that take no parameters are written 
Functions^12^ without parentheses.
Functions^13^ 
Functions^14^ The function body begins with the keyword IS and ends with the keyword END 
Functions^15^ followed by an optional function name. The function body has three parts: an 
Functions^16^ optional declarative part, an executable part, and an optional exception-
Functions^17^ handling part.
Functions^18^ 
Functions^19^ The declarative part contains declarations of types, cursors, constants, 
Functions^20^ variables, exceptions, and subprograms. These objects are local and cease to 
Functions^21^ exist when you exit the function. The executable part contains statements that 
Functions^22^ assign values, control execution, and manipulate Oracle data. The exception-
Functions^23^ handling part contains exception handlers, which deal with exceptions raised 
Functions^24^ during execution. 
Functions^25^ 
Functions^26^ function_specification 
Functions^27^   FUNCTION function_name
Functions^28^     [ (parameter_declaration[, parameter_declaration]...) ]
Functions^29^   RETURN return_type;
Functions^30^ 
Functions^31^ function_body 
Functions^32^   FUNCTION function_name
Functions^33^     [ (parameter_declaration[, parameter_declaration]...) ] 
Functions^34^   RETURN return_type IS
Functions^35^     [ [item_declaration [item_declaration] ...]
Functions^36^     [ subprogram_declaration [subprogram_declaration] ...] ]
Functions^37^   BEGIN
Functions^38^     seq_of_statements
Functions^39^   [ EXCEPTION 
Functions^40^     exception_handler [exception_handler] ...]
Functions^41^   END [function_name];
Functions^42^ 
Functions^43^ parameter_declaration 
Functions^44^   parameter_name [IN | OUT | IN OUT]
Functions^45^     { collection_name%TYPE
Functions^46^     | collection_type_name
Functions^47^     | cursor_name%ROWTYPE
Functions^48^     | cursor_variable_name%TYPE
Functions^49^     | object_name%TYPE
Functions^50^     | object_type_name
Functions^51^     | record_name%TYPE
Functions^52^     | record_type_name
Functions^53^     | scalar_type_name
Functions^54^     | table_name%ROWTYPE
Functions^55^     | table_name.column_name%TYPE
Functions^56^     | variable_name%TYPE}
Functions^57^     [ {:= | DEFAULT} expression ]
Functions^58^ 
Functions^59^ return_type 
Functions^60^   { collection_name%TYPE
Functions^61^   | collection_type_name
Functions^62^   | cursor_name%ROWTYPE
Functions^63^   | cursor_variable_name%ROWTYPE
Functions^64^   | object_name%TYPE
Functions^65^   | object_type_name
Functions^66^   | record_name%TYPE
Functions^67^   | record_type_name
Functions^68^   | scalar_type_name
Functions^69^   | table_name%ROWTYPE
Functions^70^   | table_name.column_name%TYPE
Functions^71^   | variable_name%TYPE }
Functions^72^ 
Functions^73^ item_declaration 
Functions^74^   { collection_declaration
Functions^75^   | constant_declaration
Functions^76^   | cursor_declaration
Functions^77^   | cursor_variable_declaration
Functions^78^   | exception_declaration
Functions^79^   | object_declaration
Functions^80^   | record_declaration
Functions^81^   | variable_declaration }
Functions^82^ 
Functions^83^ subprogram_declaration 
Functions^84^   {function_declaration | procedure_declaration}
Functions^85^ 
Functions^86^ For detailed information on functions, see the PL/SQL User's Guide and 
Functions^87^ Reference.
Functions^88^ 
GOTO Statement^1^ 
GOTO Statement^2^ GOTO Statement
GOTO Statement^3^ --------------
GOTO Statement^4^ 
GOTO Statement^5^ The GOTO statement branches unconditionally to a statement label or block 
GOTO Statement^6^ label. The label must be unique within its scope and must precede an 
GOTO Statement^7^ executable statement or a PL/SQL block. The GOTO statement transfers control 
GOTO Statement^8^ to the labelled statement or block.
GOTO Statement^9^ 
GOTO Statement^10^ label_declaration  
GOTO Statement^11^   <<label_name>>
GOTO Statement^12^ 
GOTO Statement^13^ goto_statement 
GOTO Statement^14^   GOTO label_name;
GOTO Statement^15^ 
GOTO Statement^16^ For detailed information on this statement, see the PL/SQL User's Guide and 
GOTO Statement^17^ Reference.
GOTO Statement^18^ 
IF Statement^1^ 
IF Statement^2^ IF Statement
IF Statement^3^ ------------
IF Statement^4^ 
IF Statement^5^ The IF statement lets you execute a sequence of statements conditionally. 
IF Statement^6^ Whether the sequence is executed or not depends on the value of a Boolean 
IF Statement^7^ expression.
IF Statement^8^ 
IF Statement^9^ if_statement
IF Statement^10^   IF boolean_expression THEN
IF Statement^11^     seq_of_statements
IF Statement^12^   [ELSIF boolean_expression THEN
IF Statement^13^     seq_of_statements   
IF Statement^14^   [ELSIF boolean_expression THEN
IF Statement^15^     seq_of_statements] ...]
IF Statement^16^   [ELSE
IF Statement^17^     seq_of_statements]
IF Statement^18^   END IF;
IF Statement^19^ 
IF Statement^20^ For detailed information on this statement, see the PL/SQL User's Guide and 
IF Statement^21^ Reference.
IF Statement^22^ 
INSERT Statement^1^ 
INSERT Statement^2^ INSERT Statement
INSERT Statement^3^ ----------------
INSERT Statement^4^ 
INSERT Statement^5^ The INSERT statement adds new rows of data to a specified database table or 
INSERT Statement^6^ view.
INSERT Statement^7^ 
INSERT Statement^8^ insert_statement  
INSERT Statement^9^   INSERT INTO {table_reference | (subquery)}
INSERT Statement^10^     [(column_name[, column_name]...)]
INSERT Statement^11^     {VALUES (sql_expression[, sql_expression]...) | subquery};
INSERT Statement^12^ 
INSERT Statement^13^ table_reference 
INSERT Statement^14^   [schema_name.]{table_name | view_name}[@dblink_name]
INSERT Statement^15^ 
INSERT Statement^16^ For detailed information on this statement, see the PL/SQL User's Guide and 
INSERT Statement^17^ Reference.
INSERT Statement^18^ 
Literals^1^ 
Literals^2^ Literals
Literals^3^ --------
Literals^4^ 
Literals^5^ A literal is an explicit numeric, character, string, or Boolean value not 
Literals^6^ represented by an identifier. The numeric literal 135 and the string literal 
Literals^7^ 'hello world' are examples.
Literals^8^ 
Literals^9^ numeric_literal 
Literals^10^   [+ | -]{integer | real_number}
Literals^11^ 
Literals^12^ integer 
Literals^13^   digit[digit]...
Literals^14^ 
Literals^15^ real_number 
Literals^16^   { integer[.integer]
Literals^17^   | integer.
Literals^18^   | .integer }
Literals^19^   [{E | e}[+ | -]integer]
Literals^20^ 
Literals^21^ character_literal 
Literals^22^   {'character' | ''''}
Literals^23^ 
Literals^24^ string_literal 
Literals^25^   '{character[character]... | ''['']...}'
Literals^26^ 
Literals^27^ boolean_literal 
Literals^28^   {TRUE | FALSE | NULL}
Literals^29^ 
Literals^30^ For detailed information on literals, see the PL/SQL User's Guide and 
Literals^31^ Reference.
Literals^32^ 
LOCK TABLE Statement^1^ 
LOCK TABLE Statement^2^ LOCK TABLE Statement
LOCK TABLE Statement^3^ --------------------
LOCK TABLE Statement^4^ 
LOCK TABLE Statement^5^ The LOCK TABLE statement lets you lock entire database tables in a specified 
LOCK TABLE Statement^6^ lock mode so that you can share or deny access to tables while maintaining 
LOCK TABLE Statement^7^ their integrity.
LOCK TABLE Statement^8^ 
LOCK TABLE Statement^9^ lock_table_statement  
LOCK TABLE Statement^10^   LOCK TABLE table_reference[, table_reference]...
LOCK TABLE Statement^11^   IN lock_mode MODE [NOWAIT];
LOCK TABLE Statement^12^ 
LOCK TABLE Statement^13^ table_reference 
LOCK TABLE Statement^14^   [schema_name.]{table_name | view_name}[@dblink_name]
LOCK TABLE Statement^15^ 
LOCK TABLE Statement^16^ For detailed information on this statement, see the PL/SQL User's Guide and 
LOCK TABLE Statement^17^ Reference.
LOCK TABLE Statement^18^ 
LOOP Statements^1^ 
LOOP Statements^2^ LOOP Statements
LOOP Statements^3^ ---------------
LOOP Statements^4^ 
LOOP Statements^5^ LOOP statements execute a sequence of statements multiple times. The loop 
LOOP Statements^6^ encloses the sequence of statements that is to be repeated. PL/SQL provides 
LOOP Statements^7^ the following types of loop statements:
LOOP Statements^8^ 
LOOP Statements^9^   *  basic loop
LOOP Statements^10^   *  WHILE loop
LOOP Statements^11^   *  FOR loop
LOOP Statements^12^   *  cursor FOR loop
LOOP Statements^13^ 
LOOP Statements^14^ basic_loop_statement 
LOOP Statements^15^   [<<label_name>>]
LOOP Statements^16^   LOOP
LOOP Statements^17^     seq_of_statements
LOOP Statements^18^   END LOOP [label_name];
LOOP Statements^19^ 
LOOP Statements^20^ while_loop_statement 
LOOP Statements^21^   [<<label_name>>]
LOOP Statements^22^   WHILE boolean_expression 
LOOP Statements^23^   LOOP
LOOP Statements^24^     seq_of_statements
LOOP Statements^25^   END LOOP [label_name];
LOOP Statements^26^ 
LOOP Statements^27^ for_loop_statement 
LOOP Statements^28^   [<<label_name>>]
LOOP Statements^29^   FOR index_name IN [REVERSE] lower_bound..upper_bound 
LOOP Statements^30^   LOOP
LOOP Statements^31^     seq_of_statements
LOOP Statements^32^   END LOOP [label_name];
LOOP Statements^33^ 
LOOP Statements^34^ cursor_for_loop_statement 
LOOP Statements^35^   [<<label_name>>]
LOOP Statements^36^   FOR record_name IN 
LOOP Statements^37^     { cursor_name
LOOP Statements^38^       [ (cursor_parameter_name[, cursor_parameter_name]...) ]
LOOP Statements^39^     | (select_statement) } 
LOOP Statements^40^   LOOP
LOOP Statements^41^     seq_of_statements
LOOP Statements^42^   END LOOP [label_name];
LOOP Statements^43^ 
LOOP Statements^44^ For detailed information on these statements, see the PL/SQL User's Guide and 
LOOP Statements^45^ Reference.
LOOP Statements^46^ 
NULL Statement^1^ 
NULL Statement^2^ NULL Statement
NULL Statement^3^ --------------
NULL Statement^4^ 
NULL Statement^5^ The NULL statement explicitly specifies inaction; it does nothing other than 
NULL Statement^6^ pass control to the next statement. In a construct allowing alternative 
NULL Statement^7^ actions, the NULL statement serves as a placeholder.
NULL Statement^8^ 
NULL Statement^9^ null_statement  
NULL Statement^10^   NULL;
NULL Statement^11^ 
NULL Statement^12^ For detailed information on this statement, see the PL/SQL User's Guide and 
NULL Statement^13^ Reference.
NULL Statement^14^ 
Object Types^1^ 
Object Types^2^ Object Types
Object Types^3^ ------------
Object Types^4^ 
Object Types^5^ An object type is a user-defined composite datatype that encapsulates a data 
Object Types^6^ structure along with the functions and procedures needed to manipulate the 
Object Types^7^ data. The variables that form the data structure are called attributes. The 
Object Types^8^ functions and procedures that characterize the behavior of the object type are 
Object Types^9^ called methods. 
Object Types^10^ 
Object Types^11^ object_type  
Object Types^12^   CREATE_TYPE type_name
Object Types^13^   {IS | AS} OBJECT
Object Types^14^   ( 
Object Types^15^     attribute_name datatype[, attribute_name datatype]...
Object Types^16^     [MEMBER {procedure_specification | function_specification}
Object Types^17^     [, MEMBER {procedure_specification | function_specification}]...]
Object Types^18^     [{MAP | ORDER} MEMBER function_specification]
Object Types^19^     [restrict_references_pragma[, restrict_references_pragma]...]
Object Types^20^   );
Object Types^21^ 
Object Types^22^ object_type_body  
Object Types^23^   CREATE_TYPE_BODY type_name {IS | AS}
Object Types^24^     MEMBER {procedure_body | function_body}; 
Object Types^25^     [MEMBER {procedure_body | function_body};] ...
Object Types^26^     [{MAP | ORDER} MEMBER function_body;] 
Object Types^27^   END;
Object Types^28^ 
Object Types^29^ For detailed information on object types, see the PL/SQL User's Guide and 
Object Types^30^ Reference.
Object Types^31^ 
OPEN Statement^1^ 
OPEN Statement^2^ OPEN Statement
OPEN Statement^3^ --------------
OPEN Statement^4^ 
OPEN Statement^5^ The OPEN statement executes the multi-row query associated with an explicit 
OPEN Statement^6^ cursor. It also allocates resources used by Oracle to process the query and 
OPEN Statement^7^ identifies the result set, which consists of all rows that meet the query 
OPEN Statement^8^ search criteria. The cursor is positioned before the first row in the result 
OPEN Statement^9^ set.
OPEN Statement^10^ 
OPEN Statement^11^ open_statement  
OPEN Statement^12^   OPEN cursor_name
OPEN Statement^13^   [ (cursor_parameter_name[, cursor_parameter_name]...) ];
OPEN Statement^14^ 
OPEN Statement^15^ For detailed information on this statement, see the PL/SQL User's Guide and 
OPEN Statement^16^ Reference.
OPEN Statement^17^ 
OPEN-FOR Statement^1^ 
OPEN-FOR Statement^2^ OPEN-FOR Statement
OPEN-FOR Statement^3^ ------------------
OPEN-FOR Statement^4^ 
OPEN-FOR Statement^5^ The OPEN-FOR statement executes the multi-row query associated with a cursor 
OPEN-FOR Statement^6^ variable. It also allocates resources used by Oracle to process the query and 
OPEN-FOR Statement^7^ identifies the result set, which consists of all rows that meet the query 
OPEN-FOR Statement^8^ search criteria. The cursor variable is positioned before the first row in the 
OPEN-FOR Statement^9^ result set.
OPEN-FOR Statement^10^ 
OPEN-FOR Statement^11^ open_for_statement  
OPEN-FOR Statement^12^   OPEN {cursor_variable_name | :host_cursor_variable_name}
OPEN-FOR Statement^13^   FOR select_statement;
OPEN-FOR Statement^14^ 
OPEN-FOR Statement^15^ For detailed information on this statement, see the PL/SQL User's Guide and 
OPEN-FOR Statement^16^ Reference.
OPEN-FOR Statement^17^ 
Packages^1^ 
Packages^2^ Packages
Packages^3^ --------
Packages^4^ 
Packages^5^ A package is a database object that groups logically related PL/SQL types, 
Packages^6^ objects, and subprograms. Packages have two parts: a specification and a body.
Packages^7^ 
Packages^8^ package_specification 
Packages^9^   PACKAGE package_name IS
Packages^10^     {item_declaration | spec_declaration}
Packages^11^     [ {item_declaration | spec_declaration} ]...
Packages^12^   END [package_name];
Packages^13^ 
Packages^14^ package_body 
Packages^15^   PACKAGE BODY package_name IS
Packages^16^     [ [item_declaration [item_declaration] ...]
Packages^17^       [body_declaration [body_declaration] ...] ]
Packages^18^   [BEGIN
Packages^19^     seq_of_statements]
Packages^20^   END [package_name];
Packages^21^ 
Packages^22^ item_declaration 
Packages^23^   { collection_declaration
Packages^24^   | constant_declaration
Packages^25^   | exception_declaration
Packages^26^   | object_declaration
Packages^27^   | record_declaration
Packages^28^   | variable_declaration }
Packages^29^ 
Packages^30^ spec_declaration 
Packages^31^   { cursor_specification
Packages^32^   | function_specification
Packages^33^   | procedure_specification }
Packages^34^ 
Packages^35^ body_declaration 
Packages^36^   { cursor_body
Packages^37^   | function_body
Packages^38^   | procedure_body }
Packages^39^ 
Packages^40^ For detailed information on packages, see the PL/SQL User's Guide and 
Packages^41^ Reference.
Packages^42^ 
Procedures^1^ 
Procedures^2^ Procedures
Procedures^3^ ----------
Procedures^4^ 
Procedures^5^ A procedure is a named PL/SQL block, which can take parameters and be invoked. 
Procedures^6^ Generally, you use a procedure to perform an action.
Procedures^7^ 
Procedures^8^ procedure_specification 
Procedures^9^   PROCEDURE procedure_name
Procedures^10^   [ (parameter_declaration[, parameter_declaration]...) ];
Procedures^11^ 
Procedures^12^ procedure_body 
Procedures^13^   PROCEDURE procedure_name
Procedures^14^   [ (parameter_declaration[, parameter_declaration]...) ]
Procedures^15^   IS
Procedures^16^   [ [item_declaration [item_declaration] ...]
Procedures^17^     [subprogram_declaration [subprogram_declaration] ...] ]
Procedures^18^   BEGIN
Procedures^19^     seq_of_statements
Procedures^20^   [EXCEPTION 
Procedures^21^     exception_handler [exception_handler] ...]
Procedures^22^   END [procedure_name];
Procedures^23^ 
Procedures^24^ parameter_declaration 
Procedures^25^   parameter_name [IN | OUT | IN OUT]
Procedures^26^     { collection_name%TYPE
Procedures^27^     | collection_type_name
Procedures^28^     | cursor_name%ROWTYPE
Procedures^29^     | cursor_variable_name%TYPE
Procedures^30^     | object_name%TYPE
Procedures^31^     | object_type_name
Procedures^32^     | record_name%TYPE
Procedures^33^     | record_type_name
Procedures^34^     | scalar_type_name
Procedures^35^     | table_name%ROWTYPE
Procedures^36^     | table_name.column_name%TYPE
Procedures^37^     | variable_name%TYPE }
Procedures^38^     [ {:= | DEFAULT} expression ]
Procedures^39^ 
Procedures^40^ item_declaration 
Procedures^41^   { collection_declaration
Procedures^42^   | constant_declaration
Procedures^43^   | cursor_declaration
Procedures^44^   | cursor_variable_declaration
Procedures^45^   | exception_declaration
Procedures^46^   | object_declaration
Procedures^47^   | record_declaration
Procedures^48^   | variable_declaration }
Procedures^49^ 
Procedures^50^ subprogram_declaration 
Procedures^51^   {function_declaration | procedure_declaration}
Procedures^52^ 
Procedures^53^ For detailed information on procedures, see the PL/SQL User's Guide and 
Procedures^54^ Reference.
Procedures^55^ 
RAISE Statement^1^ 
RAISE Statement^2^ RAISE Statement
RAISE Statement^3^ ---------------
RAISE Statement^4^ 
RAISE Statement^5^ The RAISE statement stops normal execution of a PL/SQL block or subprogram and 
RAISE Statement^6^ transfers control to the appropriate exception handler.
RAISE Statement^7^ 
RAISE Statement^8^ raise_statement
RAISE Statement^9^   RAISE [exception_name];
RAISE Statement^10^ 
RAISE Statement^11^ For detailed information on this statement, see the PL/SQL User's Guide and 
RAISE Statement^12^ Reference.
RAISE Statement^13^ 
Records^1^ 
Records^2^ Records
Records^3^ -------
Records^4^ 
Records^5^ Records are objects of type RECORD. Records have uniquely named fields that 
Records^6^ can store data values of different types.
Records^7^ 
Records^8^ To create records, you define a RECORD type, then declare user-defined records 
Records^9^ of that type.
Records^10^ 
Records^11^ record_type_definition 
Records^12^   TYPE record_type_name IS RECORD
Records^13^    (field_declaration[, field_declaration]...);
Records^14^ 
Records^15^ record_declaration 
Records^16^   record_name record_type_name;
Records^17^ 
Records^18^ field_declaration 
Records^19^   field_name 
Records^20^     { collection_name%TYPE
Records^21^     | collection_type_name
Records^22^     | cursor_name%ROWTYPE
Records^23^     | local_field_name%TYPE
Records^24^     | object_name%TYPE
Records^25^     | object_type_name
Records^26^     | record_name%TYPE
Records^27^     | record_type_name
Records^28^     | scalar_type_name   
Records^29^     | table_name%ROWTYPE
Records^30^     | table_name.column_name%TYPE
Records^31^     | variable_name%TYPE }
Records^32^     [ [NOT NULL] {:= | DEFAULT} expression ]
Records^33^ 
Records^34^ For detailed information on records, see the PL/SQL User's Guide and 
Records^35^ Reference.
Records^36^ 
RETURN Statement^1^ 
RETURN Statement^2^ RETURN Statement
RETURN Statement^3^ ----------------
RETURN Statement^4^ 
RETURN Statement^5^ The RETURN statement immediately completes the execution of a subprogram and 
RETURN Statement^6^ returns control to the caller. Execution then resumes with the statement 
RETURN Statement^7^ following the subprogram call. In a function, the RETURN statement also sets 
RETURN Statement^8^ the function identifier to the result value.
RETURN Statement^9^ 
RETURN Statement^10^ return_statement  
RETURN Statement^11^   RETURN [expression];
RETURN Statement^12^ 
RETURN Statement^13^ For detailed information on this statement, see the PL/SQL User's Guide and 
RETURN Statement^14^ Reference.
RETURN Statement^15^ 
ROLLBACK Statement^1^ 
ROLLBACK Statement^2^ ROLLBACK Statement
ROLLBACK Statement^3^ ------------------
ROLLBACK Statement^4^ 
ROLLBACK Statement^5^ The ROLLBACK statement is the inverse of the COMMIT statement. It undoes some 
ROLLBACK Statement^6^ or all database changes made during the current transaction.
ROLLBACK Statement^7^ 
ROLLBACK Statement^8^ rollback_statement
ROLLBACK Statement^9^   ROLLBACK [WORK] [TO [SAVEPOINT] savepoint_name];
ROLLBACK Statement^10^ 
ROLLBACK Statement^11^ For detailed information on this statement, see the PL/SQL User's Guide and 
ROLLBACK Statement^12^ Reference.
ROLLBACK Statement^13^ 
%ROWTYPE Attribute^1^ 
%ROWTYPE Attribute^2^ %ROWTYPE Attribute
%ROWTYPE Attribute^3^ ------------------
%ROWTYPE Attribute^4^ 
%ROWTYPE Attribute^5^ The %ROWTYPE attribute provides a record type that represents a row in a 
%ROWTYPE Attribute^6^ database table. The record can store an entire row of data selected from the 
%ROWTYPE Attribute^7^ table or fetched from a cursor or cursor variable.
%ROWTYPE Attribute^8^ 
%ROWTYPE Attribute^9^ You can use the %ROWTYPE attribute in variable declarations as a datatype 
%ROWTYPE Attribute^10^ specifier. Variables declared using %ROWTYPE are treated like those declared 
%ROWTYPE Attribute^11^ using a datatype name.
%ROWTYPE Attribute^12^ 
%ROWTYPE Attribute^13^ rowtype_attribute 
%ROWTYPE Attribute^14^   {cursor_name | cursor_variable_name | table_name}%ROWTYPE
%ROWTYPE Attribute^15^ 
%ROWTYPE Attribute^16^ For detailed information on the %ROWTYPE attribute, see the PL/SQL User's 
%ROWTYPE Attribute^17^ Guide and Reference.
%ROWTYPE Attribute^18^ 
SAVEPOINT Statement^1^ 
SAVEPOINT Statement^2^ SAVEPOINT Statement
SAVEPOINT Statement^3^ -------------------
SAVEPOINT Statement^4^ 
SAVEPOINT Statement^5^ The SAVEPOINT statement names and marks the current point in the processing of 
SAVEPOINT Statement^6^ a transaction. With the ROLLBACK TO statement, savepoints let you undo parts 
SAVEPOINT Statement^7^ of a transaction instead of the whole transaction.
SAVEPOINT Statement^8^ 
SAVEPOINT Statement^9^ savepoint_statement
SAVEPOINT Statement^10^   SAVEPOINT savepoint_name;
SAVEPOINT Statement^11^ 
SAVEPOINT Statement^12^ For detailed information on this statement, see the PL/SQL User's Guide and 
SAVEPOINT Statement^13^ Reference.
SAVEPOINT Statement^14^ 
SELECT INTO Statement^1^ 
SELECT INTO Statement^2^ SELECT INTO Statement
SELECT INTO Statement^3^ ---------------------
SELECT INTO Statement^4^ 
SELECT INTO Statement^5^ The SELECT INTO statement retrieves data from one or more database tables, 
SELECT INTO Statement^6^ then assigns the selected values to variables or fields.
SELECT INTO Statement^7^ 
SELECT INTO Statement^8^ select_into_statement 
SELECT INTO Statement^9^   SELECT
SELECT INTO Statement^10^     [DISTINCT | ALL]
SELECT INTO Statement^11^     {* | select_item[, select_item]...}
SELECT INTO Statement^12^   INTO
SELECT INTO Statement^13^     {variable_name[, variable_name]... | record_name}
SELECT INTO Statement^14^   FROM
SELECT INTO Statement^15^     {table_reference | (subquery)}
SELECT INTO Statement^16^     [alias]
SELECT INTO Statement^17^     [, {table_reference | (subquery)}
SELECT INTO Statement^18^       [alias] ]...
SELECT INTO Statement^19^     rest_of_select_statement;
SELECT INTO Statement^20^ 
SELECT INTO Statement^21^ select_item 
SELECT INTO Statement^22^   { function_name[(parameter_name[, parameter_name]...)]
SELECT INTO Statement^23^   | NULL
SELECT INTO Statement^24^   | numeric_literal
SELECT INTO Statement^25^   | [schema_name.]{table_name | view_name}.*
SELECT INTO Statement^26^   | [[schema_name.]{table_name. | view_name.}]column_name
SELECT INTO Statement^27^   | sequence_name.{CURRVAL | NEXTVAL}
SELECT INTO Statement^28^   | 'text'}
SELECT INTO Statement^29^   [ [AS] alias ]
SELECT INTO Statement^30^ 
SELECT INTO Statement^31^ table_reference 
SELECT INTO Statement^32^   [schema_name.]{table_name | view_name}[@dblink_name]
SELECT INTO Statement^33^ 
SELECT INTO Statement^34^ For detailed information on this statement, see the PL/SQL User's Guide and 
SELECT INTO Statement^35^ Reference.
SELECT INTO Statement^36^ 
SET TRANSACTION Statement^1^ 
SET TRANSACTION Statement^2^ SET TRANSACTION Statement
SET TRANSACTION Statement^3^ -------------------------
SET TRANSACTION Statement^4^ 
SET TRANSACTION Statement^5^ The SET TRANSACTION statement begins a read-only or read-write transaction, 
SET TRANSACTION Statement^6^ establishes an isolation level, or assigns the current transaction to a 
SET TRANSACTION Statement^7^ specified rollback segment.
SET TRANSACTION Statement^8^ 
SET TRANSACTION Statement^9^ set_transaction_statement  
SET TRANSACTION Statement^10^   SET TRANSACTION
SET TRANSACTION Statement^11^     { READ ONLY
SET TRANSACTION Statement^12^     | READ WRITE
SET TRANSACTION Statement^13^     | ISOLATION LEVEL {SERIALIZABLE | READ COMMITTED}
SET TRANSACTION Statement^14^     | USE ROLLBACK SEGMENT rollback_segment_name };
SET TRANSACTION Statement^15^ 
SET TRANSACTION Statement^16^ For detailed information on this statement, see the PL/SQL User's Guide and 
SET TRANSACTION Statement^17^ Reference.
SET TRANSACTION Statement^18^ 
SQL Cursor^1^ 
SQL Cursor^2^ SQL Cursor
SQL Cursor^3^ ----------
SQL Cursor^4^ 
SQL Cursor^5^ Oracle implicitly opens a cursor to process each SQL statement not associated 
SQL Cursor^6^ with an explicit cursor.
SQL Cursor^7^ 
SQL Cursor^8^ sql_cursor  
SQL Cursor^9^   SQL{%FOUND | %ISOPEN | %NOTFOUND | %ROWCOUNT}
SQL Cursor^10^ 
SQL Cursor^11^ For detailed information on SQL cursor, see the PL/SQL User's Guide and 
SQL Cursor^12^ Reference.
SQL Cursor^13^ 
SQLCODE Function^1^ 
SQLCODE Function^2^ SQLCODE Function
SQLCODE Function^3^ ----------------
SQLCODE Function^4^ 
SQLCODE Function^5^ The function SQLCODE returns the number code associated with the most recently 
SQLCODE Function^6^ raised exception. SQLCODE is meaningful only in an exception handler. Outside 
SQLCODE Function^7^ a handler, SQLCODE always returns zero.
SQLCODE Function^8^ 
SQLCODE Function^9^ sqlcode_function 
SQLCODE Function^10^   SQLCODE
SQLCODE Function^11^ 
SQLCODE Function^12^ For detailed information on the SQLCODE function, see the PL/SQL User's Guide 
SQLCODE Function^13^ and Reference.
SQLCODE Function^14^ 
SQLERRM Function^1^ 
SQLERRM Function^2^ SQLERRM Function
SQLERRM Function^3^ ----------------
SQLERRM Function^4^ 
SQLERRM Function^5^ The function SQLERRM returns the error message associated with its error-
SQLERRM Function^6^ number argument or, if the argument is omitted, with the current value of 
SQLERRM Function^7^ SQLCODE. SQLERRM with no argument is meaningful only in an exception handler. 
SQLERRM Function^8^ Outside a handler, SQLERRM with no argument always returns the message normal, 
SQLERRM Function^9^ successful completion.
SQLERRM Function^10^ 
SQLERRM Function^11^ sqlerrm_function 
SQLERRM Function^12^   SQLERRM [(error_number)]
SQLERRM Function^13^ 
SQLERRM Function^14^ For detailed information on the SQLERRM Function, see the PL/SQL User's Guide 
SQLERRM Function^15^ and Reference.
SQLERRM Function^16^ 
%TYPE Attribute^1^ 
%TYPE Attribute^2^ %TYPE Attribute
%TYPE Attribute^3^ ---------------
%TYPE Attribute^4^ 
%TYPE Attribute^5^ The %TYPE attribute provides the datatype of a field, record, nested table, 
%TYPE Attribute^6^ database column, or variable. You can use the %TYPE attribute as a datatype 
%TYPE Attribute^7^ specifier when declaring constants, variables, fields, and parameters. 
%TYPE Attribute^8^ 
%TYPE Attribute^9^ type_attribute  
%TYPE Attribute^10^   { collection_name
%TYPE Attribute^11^   | cursor_variable_name
%TYPE Attribute^12^   | object name
%TYPE Attribute^13^   | record_name
%TYPE Attribute^14^   | record_name.field_name
%TYPE Attribute^15^   | table_name.column_name
%TYPE Attribute^16^   | variable_name } %TYPE
%TYPE Attribute^17^ 
%TYPE Attribute^18^ For detailed information on the %TYPE Attribute, see the PL/SQL User's Guide 
%TYPE Attribute^19^ and Reference.
%TYPE Attribute^20^ 
UPDATE Statement^1^ 
UPDATE Statement^2^ UPDATE Statement
UPDATE Statement^3^ ----------------
UPDATE Statement^4^ 
UPDATE Statement^5^ The UPDATE statement changes the values of specified columns in one or more 
UPDATE Statement^6^ rows in a table or view.
UPDATE Statement^7^ 
UPDATE Statement^8^ update_statement  
UPDATE Statement^9^   UPDATE
UPDATE Statement^10^     { table_reference | (subquery) }
UPDATE Statement^11^     [ alias ]
UPDATE Statement^12^   SET
UPDATE Statement^13^     { column_name = {sql_expression | (subquery)}
UPDATE Statement^14^     | (column_name[, column_name]...) = (subquery)}
UPDATE Statement^15^     [, {  column_name = {sql_expression | (subquery)}
UPDATE Statement^16^        | (column_name[, column_name]...) = (subquery)} ]...
UPDATE Statement^17^  [ WHERE {search_condition | CURRENT OF cursor_name} ]; 
UPDATE Statement^18^ 
UPDATE Statement^19^ table_reference 
UPDATE Statement^20^   [schema_name.]{table_name | view_name}[@dblink_name]
UPDATE Statement^21^ 
UPDATE Statement^22^ For detailed information on this statement, see the PL/SQL User's Guide 
UPDATE Statement^23^ and Reference.
UPDATE Statement^24^ 
UPDATE Statement^25^
UPDATE Statement^26^
UPDATE Statement^27^
