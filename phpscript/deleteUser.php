<?php

class  insertTable
{
    const DB_HOST = 'localhost';

    const DB_NAME = 'id12866202_boilerbite';

    const DB_USER = 'id12866202_bb307';

    const DB_PASS = 'bb307';

    private $pdo = null;

    public function __construct()
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);

        try {
            $this->pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
    public function __destruct()
    {
        // close the database connection
        $this->pdo = null;
    }

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */

    function removeUser($username, $pass)
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            // Check if username is in database.
            // If username is in the table display error message and return.
            $sql = "SELECT hashPass FROM profiles WHERE userName = '$username'";

            // Execute query to get userName.
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);

            // Store fetch() result into $result.
            $pass_result = $q->fetch();
            // Check if query returned values
            if ($pass_result) {
                // Store result into $holder to check with password provided
                $holder = $pass_result['hashPass'];
                //echo "$holder";
            } else {
                // Return function since query returned nothing
                echo nl2br("\nNo such user.\n");
                return;
            }
            // Obtain the hashed version of the provided password
            $pass = sha1($pass);
            // Compare password from database and provided password, delete user if passwords match
            if (!strcmp($holder, $pass)) {
                // Delete user from profiles
                $sql = "DELETE FROM profiles WHERE userName = :name";
                $delete = $this->pdo->prepare($sql);
                $delete->bindValue(':name', $username);
                $delete->execute();

                // Delete user from goals
                $sql = "DELETE FROM goals WHERE userName = :name";
                $delete = $this->pdo->prepare($sql);
                $delete->bindValue(':name', $username);
                $delete->execute();

                //Delete user from info
                $sql = "DELETE FROM info WHERE userName = :name";
                $delete = $this->pdo->prepare($sql);
                $delete->bindValue(':name', $username);
                $delete->execute();

                // Delete user from progress
                $sql = "DELETE FROM progress WHERE userName = :name";
                $delete = $this->pdo->prepare($sql);
                $delete->bindValue(':name', $username);
                $delete->execute();
            } else {
                echo nl2br("Incorrect password.");
            }
        } catch (PDOException $e) {
            //echo $e->getMessage();
            return false;
        }
        return true;
    }

    // Function to show users in table
    function showUsers(): void
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT  userName,
                        userEmail,
                        hashPass
                    FROM profiles;';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $flag = 0;
        while ($user = $q->fetch()) {
            $holder = $user['userName'];
            echo "Username: $holder, ";
            $holder = $user['userEmail'];
            echo "Email: $holder, ";
            $holder = $user['hashPass'];
            echo "Passwrd: $holder\n\n";
            $flag = 1;
        }
        if ($flag == 0) {
            echo nl2br("No users in the database.\n\n");
        }
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
//$obj->showUsers();

// Get values from ios application
$username = "Jeremy"; //$_POST['userName'];
$pass = "jeremy"; //$_POST['pass'];
//echo nl2br(" \nRemoving:
//Username: $username, Password: $pass\n");
if ($obj->removeUser($username, $pass)) {
    echo nl2br("User deleted.\n");
} else {
    echo nl2br("User deletion failed.\n");
}

//$obj->showUsers();
?>

<html>

<head>
    <title>
        deleteUser
    </title>
</head>

</html>