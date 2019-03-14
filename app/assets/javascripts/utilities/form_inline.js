document.addEventListener("turbolinks:load", function () {
    $(".inline-form-edit-link").on("click", formInlineLinkHandler);

    var errors = document.querySelector(".resource-errors");
    if (errors) {
        var resourceId = errors.dataset.resourceId;
        formInlineHandler(resourceId);

    }
});

function formInlineLinkHandler(event) {
    event.preventDefault();

    var testId = this.dataset.testId;
    formInlineHandler(testId);
}

function formInlineHandler(testId) {
    var link = document.querySelector('.inline-form-edit-link[data-test-id="' + testId + '"]'),
        $testTitle = $('.test-title[data-test-id="' + testId + '"]'),
        $formInline = $('.form-inline[data-test-id="' + testId + '"]');

    $testTitle.toggle();
    $formInline.toggle();

    if ($formInline.is(":visible")) {
        link.textContent = "Cancel";
    } else {
        link.textContent = "Edit";
    }
}
