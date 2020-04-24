<html>
   
   <head>
      <title>Sending HTML email using PHP</title>
   </head>
   
   <body>
      
      <?php
         
         $feedback = isset($_GET['feedback']) ? $_GET['feedback'] : '';
         $feedback = !empty($_GET['feedback']) ? $_GET['feedback'] : '';
      
         $to = "udaydagr8@gmail.com";
         $subject = "Feedback From User";
         
         $message = "<b> $feedback </b>";
         //$message .= "<h1>This is a feedback.</h1>";
         
         $header = "From:boilerbite@purdue.com \r\n";
         //$header .= "Cc:afgh@somedomain.com \r\n";
         $header .= "MIME-Version: 1.0\r\n";
         $header .= "Content-type: text/html\r\n";
         
         $retval = mail ($to,$subject,$message,$header);
         
         if( $retval == true ) {
            echo "Message sent successfully...";
         }else {
            echo "Message could not be sent...";
         }
      ?>
      
   </body>
</html>