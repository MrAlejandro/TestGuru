document.addEventListener('turbolinks:load', function () {
    var progressBarWrapper = document.querySelector('.progress'),
        progressBar = progressBarWrapper.querySelector('.progress-bar'),
        currentItem = parseInt(progressBarWrapper.dataset.currentItem),
        totalItems = parseInt(progressBarWrapper.dataset.totalItems);

    if (!totalItems || !currentItem) {
        return;
    }

    var progress = (currentItem - 1) / totalItems * 100;
    progressBar.style = "width: " + progress + "%";
    progressBar.setAttribute('aria-valuenow', progress);
});
