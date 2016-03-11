<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 18.11.2014
 * Time: 03:11
 */

	if(isset($_GET['first_name']))
    {
        if(strlen($_GET['first_name']) > 8)
        {
            echo  $_GET['first_name'];
		}

	}
?>
<form  method="get" action="XSS1.php">
    First name: <input type="text" name="first_name" /><br />
    <input type="submit" value="Submit" />
</form>

