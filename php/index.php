<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
  echo "POST Data: ";
  print_r($_POST);
}
// print_r("\n");
// print_r($_SERVER);
// echo "\n";
// print_r("\n");
// print_r($_GET);
// echo "\n";
// print_r("\n");
// print_r($_POST);
// echo "\n";
// print_r("\n");
// print_r($_COOKIE);
// echo "\n";
// print_r("\n");
print_r($_SESSION ?? []);
echo "\n";
print_r("\n");
if ($_SERVER["REQUEST_METHOD"] === "GET" && isset($_GET["name"])) {
  echo "GET Dataaaaa: ", $_SERVER["REQUEST_METHOD"] === "GET";
  print_r($_GET);
}
?>

<form method="POST">
  <label>Name (POST):</label>
  <input type="text" name="name">
  <input type="submit" value="Send POST">
</form>

<br>

<form method="GET">
  <label>Name (GET):</label>
  <input type="text" name="name">
  <input type="submit" value="Send GET">
</form>
