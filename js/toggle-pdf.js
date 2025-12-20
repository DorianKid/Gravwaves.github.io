// Toggle para mostrar/ocultar contenedores (usado principalmente para PDFs)
function togglePDF(id) {
  var container = document.getElementById(id);
  if (container.style.display === "none" || container.style.display === "") {
    container.style.display = "block";
  } else {
    container.style.display = "none";
  }
}