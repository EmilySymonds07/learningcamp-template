// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as ActiveStorage from "@rails/activestorage"

ActiveStorage.start()

Turbo.StreamActions.redirect = function() {
  Turbo.visit(this.target);
};

const adapter = Turbo.navigator.delegate.adapter;

document.addEventListener('turbo:before-fetch-request', function(event) {
  const target = event.target;
  if (!(target instanceof HTMLElement)) return;

  if (target.getAttribute('data-turbo-action') === 'advance') {
    adapter.formSubmissionStarted(this)
  }
});

document.addEventListener('turbo:before-fetch-response', function(event) {
  adapter.formSubmissionFinished(this);
});

document.addEventListener("DOMContentLoaded", function() {
  const modal = document.getElementById("modal");
  const closeButton = document.getElementById("close-modal");

  closeButton.addEventListener("click", function() {
    modal.style.display = "none"; // Ocultar el modal
  });
});

