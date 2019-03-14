document.addEventListener('turbolinks:load', function () {
    var confirmationField = document.getElementById('user_password_confirmation'),
        passwordField = document.getElementById('user_password');

    if (!confirmationField || !passwordField) {
        return;
    }

    confirmationField.addEventListener('input', showPasswordsMatchResult);
    passwordField.addEventListener('input', showPasswordsMatchResult);
});

function showPasswordsMatchResult() {
    var passwordConfirmation = document.getElementById('user_password_confirmation').value,
        password = document.getElementById('user_password').value,
        successIcon = document.querySelector('.octicon-check'),
        failIcon = document.querySelector('.octicon-x');

    if (passwordConfirmation === '') {
        successIcon.classList.add('hide');
        failIcon.classList.add('hide');
    } else if (password === passwordConfirmation) {
        successIcon.classList.remove('hide');
        failIcon.classList.add('hide');
    } else {
        successIcon.classList.add('hide');
        failIcon.classList.remove('hide');
    }
}
