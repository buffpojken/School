#! /usr/bin/php
<?php

// Open a connection to mysql on localhost
mysql_connect('127.0.0.1','root', '');
// Choose the proper databae or crash loudly
mysql_select_db("MCH") or die( "Unable to select database");
// Fetch a result based on the provided query, using wildcard matching
$result=mysql_query("select * from lamps where namn like '%Halogen%'");
// For all fetched results
while($i < mysql_numrows($result)){
	 // Fetch the value on field 'namn' and print it, followed by a newline
	 echo mysql_result($result, $i, "namn")."\n";
	 // Increment counter
	 $i++;
}

?>