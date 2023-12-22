class ConstantSql{

  String insertData(String note, String title) {
    String escapedNote = note.replaceAll("'", "''");
    String escapedTitle = title.replaceAll("'", "''");
    return "INSERT INTO mynotes (note, title) VALUES ('$escapedNote', '$escapedTitle')";
  }

  String updateData(int id, String note, String title) {
    String escapedNote = note.replaceAll("'", "''");
    String escapedTitle = title.replaceAll("'", "''");
    return "UPDATE mynotes SET note = '$escapedNote', title = '$escapedTitle' WHERE id = $id";
  }


  String deletData(int noteId) {
    return "DELETE FROM 'mynotes' WHERE id ='$noteId' ";
  }


  String selectAllData = "SELECT * FROM 'mynotes'";
}