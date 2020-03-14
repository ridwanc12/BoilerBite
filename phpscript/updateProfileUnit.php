<?php

class  updateRow
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

    /* Function to check if username and password match by comparing
     * userID selected from the table by both values. Returns 1 if userID
     * catches, else returns 0.
     */

    function verifyUser($username, $pass): int
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            $sql = "SELECT hashPass FROM profiles WHERE userName = '$username'";
            // Execute query to get userName.
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

        $result = $q->fetch();

        // Check if username is in database.
        // If username is not in the table $result will be FALSE.
        if ($result == FALSE) {
            echo nl2br("No such user.\n");
            return 0;
        }
        $passFromUser = $result['hashPass'];

        // Get hashed password from function input.
        $passwrd = sha1($pass);
        if ($passwrd == $passFromUser) {
            echo nl2br("User found!!!!!\n");
            return 1;
        }
        return 0;
    }

    // Function to show users in table
    function showUsers(): void
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userID,
                        userName,
                        userEmail,
                        height,
                        weight,
                        hashPass,
                        age
                    FROM profiles';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $flag = 0;
        while ($user = $q->fetch()) {
            $holder = $user['userID'];
            echo "UserID: $holder, ";
            $holder = $user['userName'];
            echo "Username: $holder, ";
            $holder = $user['userEmail'];
            echo "Email: $holder, ";
            $holder = $user['height'];
            echo "Height: $holder, ";
            $holder = $user['weight'];
            echo nl2br("Weight: $holder, \n");
            $holder = $user['hashPass'];
            echo "Hashed Passwrd: $holder, ";
            $holder = $user['age'];
            echo nl2br("Age: $holder\n\n");
            $flag = 1;
        }
        if ($flag == 0) {
            echo nl2br("No users in the database.\n\n");
        }
    }

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */

    function updateWholeRow($username, $height, $weight, $pass, $age)
    {
        $flag = 0;
        $error = '';

        // Check to make sure height is non-negative.
        // Appends error message if height is negative.
        if ($height < 0) {
            $error = $error . "Please make sure height is non-negative.\r\n";
            $flag = 1;
        }

        // Check to make sure weight is non-negative.
        // Appends error message if weight is negative.
        if ($weight < 0) {
            $error = $error . "Please make sure weight is non-negative.\r\n";
            $flag = 1;
        }

        // Check to make sure age is non-negative.
        // Appends error message if age is negative.
        if ($age < 0) {
            $error = $error . "Please make sure age is non-negative.\r\n";
            $flag = 1;
        }

        // Check if there's any errors with inputs.
        // Print error message and exit.
        if ($flag == 1) {
            $error = $error . "Query failed.\n";
            echo nl2br($error);
            return 0;
        }

        $passCheck = $this->verifyUser($username, $pass);

        // exit() if username and password doesn't match.
        if ($passCheck == 0) {
            echo nl2br("Incorrect username and password.\n");
            return 0;
        }

        $task = array(
            ':height' => $height,
            ':weight' => $weight,
            ':age' => $age,
            ':username' => $username
        );
        // Write query to collect data
        $sql = 'UPDATE profiles
                    SET height          = :height,
                        weight          = :weight,
                        age             = :age
                    WHERE  userName = :username';

        $q = $this->pdo->prepare($sql);
        return $q->execute($task);
    }
}
$obj = new updateRow();

// Show user profiles in the database
$obj->showUsers();
echo nl2br("Begin Unit test for updating Profile:\n\n");


// Unit Test: Negative height
$username = 'Rid';
$height = '-56';
$weight = '75';
$pass = 'rid';
$age = '20';
echo nl2br("Testing when user enters a negative height.
                Username: $username, Height: $height, Weight: $weight,\n Password: $pass, Age: $age\n");
if ($obj->updateWholeRow($username, $height, $weight, $pass, $age)) {
    echo nl2br("Query executed.\n\n");
} else {
    echo nl2br("Query error.\n\n");
};

// Unit Test: Negative weight
$username = 'Rid';
$height = '56';
$weight = '-75';
$pass = 'rid';
$age = '20';
echo nl2br("Testing when user enters a negative weight.
                Username: $username, Height: $height, Weight: $weight,\n Password: $pass, Age: $age\n");
if ($obj->updateWholeRow($username, $height, $weight, $pass, $age)) {
    echo nl2br("Query executed.\n\n");
} else {
    echo nl2br("Query error.\n\n");
};

// Unit Test: Negative age
$username = 'Rid';
$height = '56';
$weight = '75';
$pass = 'rid';
$age = '-20';
echo nl2br("Testing when user enters a negative age.
                Username: $username, Height: $height, Weight: $weight,\n Password: $pass, Age: $age\n");
if ($obj->updateWholeRow($username, $height, $weight, $pass, $age)) {
    echo nl2br("Query executed.\n\n");
} else {
    echo nl2br("Query error.\n\n");
};

// Unit Test: All negative values
$username = 'Rid';
$height = '-56';
$weight = '-75';
$pass = 'rid';
$age = '-20';
echo nl2br("Testing when user enters all negative values.
                Username: $username, Height: $height, Weight: $weight,\n Password: $pass, Age: $age\n");
if ($obj->updateWholeRow($username, $height, $weight, $pass, $age)) {
    echo nl2br("Query executed.\n\n");
} else {
    echo nl2br("Query error.\n\n");
};

// Unit Test: User not in database
$username = 'Jesus';
$height = '156';
$weight = '75';
$pass = 'rid';
$age = '20';
echo nl2br("Testing when user is not present in database.
                Username: $username, Height: $height, Weight: $weight,\n Password: $pass, Age: $age\n");
if ($obj->updateWholeRow($username, $height, $weight, $pass, $age)) {
    echo nl2br("Query executed.\n\n");
} else {
    echo nl2br("Query error.\n\n");
};

// Unit Test: All values are valid
$username = 'Rid';
$height = '0';
$weight = '0';
$pass = 'rid';
$age = '0';
echo nl2br("Testing when user inputs all valid values.
                Username: $username, Height: $height, Weight: $weight,\n Password: $pass, Age: $age\n");
if ($obj->updateWholeRow($username, $height, $weight, $pass, $age)) {
    echo nl2br("Query executed.\n\n");
} else {
    echo nl2br("Query error.\n\n");
};
$obj->showUsers();
