class ConstantSql{

  String insertData(String note, String title) {
    String escapedNote = note.replaceAll("'", "''");
    String escapedTitle = title.replaceAll("'", "''");
    return "INSERT INTO mynotes (note, title) VALUES ('$escapedNote', '$escapedTitle')";
  }

  String deletData = "DELETE FROM 'mynotes' WHERE id = 1";
  String selectData = "SELECT note FROM 'mynotes'";
  String selectData2 = "SELECT title FROM 'mynotes'";
}