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

  String deletTrashData(int noteId) {
    return "DELETE FROM 'trash' WHERE id ='$noteId' ";
  }

  String selectAllData() {
    return "SELECT * FROM 'mynotes'";
  }
  String selectAllTrash() {
    return "SELECT * FROM 'trash'";
  }

  String searchData(String data ) {
    String escapedData = data.replaceAll("'", "''");
    return "SELECT id,note,title FROM 'mynotes' WHERE title LIKE '%$escapedData%' or note LIKE '%$escapedData%'";
  }

  String searchTrashData(String data ) {
    String escapedData = data.replaceAll("'", "''");
    return "SELECT id,note,title FROM 'trash' WHERE title LIKE '%$escapedData%' or note LIKE '%$escapedData%'";
  }

  String moveToTrash(int id, String note, String title) {
    String escapedNote = note.replaceAll("'", "''");
    String escapedTitle = title.replaceAll("'", "''");
    return "INSERT INTO trash (id, note, title) VALUES ($id, '$escapedNote', '$escapedTitle')";
  }

  String selectToDelet(int id) {
    return "SELECT * FROM 'mynotes' WHERE id =$id";
  }


}