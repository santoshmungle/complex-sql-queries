/************************************************************************************************
Title:			SQL Queries Part3
Created by: Santosh Mungle  <santoshmungle@gmail.com>
License:		CC BY 3.0

Usage:
In this part, we are considering a database which includes the following tables: 
table: documents
columns: doc_id(pk), doc_date 

table: keywords
columns: key_word_id (pk), key_word

table: document_keywords
columns: doc_id,keyword_id 
************************************************************************************************/
Query 1. Documents with a date after 4/1/1995.
Solution:
/*Documents is my database where I have tables documents, keywords, document_keywords*/
USE Documents
GO
SELECT * FROM documents WHERE doc_date > '4/1/1995'


Query 2.Documents that contain the keyword "Blue" 
Solution:
/*Documents is my database where I have tables documents, keywords, document_keywords*/
USE Documents
GO
SELECT doc_id, key_word FROM document_keywords, keywords 
WHERE document_keywords.[key_word_id ]=keywords.[key_word_id ] AND key_word LIKE '%Blue%'


Query 3. Documents that contain either the keyword "Blue" or "Yellow" 
Solution:
USE Documents
GO
SELECT doc_id, key_word FROM document_keywords, keywords 
WHERE document_keywords.[key_word_id ]=keywords.[key_word_id ] AND (key_word LIKE '%Blue%' 
OR key_word LIKE '%Yellow%')


Query 4. Documents that contain both the keywords "Blue" and "Yellow"
Solution:
/*Documents is my database where I have tables documents, keywords, document_keywords*/
USE Documents
GO
SELECT doc_id, key_word FROM document_keywords, keywords 
WHERE document_keywords.[key_word_id ]=keywords.[key_word_id ] AND (key_word LIKE '%Blue%' 
AND key_word LIKE '%Yellow%')
