$(document).on('turbolinks:load', function (e) {
    var $timer = $('.timer'),
        timeLeft = parseInt($timer.data('timeLeft'));

    if (timeLeft < 0) {
        finishTest();
    } else {
        startCountdown();
    }

    function finishTest() {
        $('.btn-next-question').click();
    }

    function startCountdown() {
        $timer.html(timeLeft);

        var countdown = setInterval(function () {
            var timeLeft = parseInt($timer.html()) - 1;
            if (timeLeft < 0) {
                finishTest();
                clearInterval(countdown);
                return;
            }

            $timer.html(timeLeft);
        }, 1000);
    }
});
