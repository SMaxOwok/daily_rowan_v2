document.addEventListener("turbolinks:load", init);
document.addEventListener("DOMContentLoaded", init);

function init() {
  const uploader = document.querySelector("#upload-file");
  const submit = document.querySelector("#upload-form-submit");

  if (uploader) uploader.addEventListener("change", handleChange);
  if (submit) submit.addEventListener("click", handleSubmit);
}

function handleChange(event) {
  const uploader = event.target;
  const label = uploader.parentNode.querySelector("span");
  const file = uploader.files[0];

  if (file && label) {
    label.textContent = file.name;
  }
}

function handleSubmit(event) {
  const submit = event.target;
  const loader = document.querySelector(".loader");
  if (!loader || !submit) return null;

  loader.style.display = "inline-block";
  submit.style.display = "none";
}