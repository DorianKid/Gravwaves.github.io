document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".parallax").forEach(function (el) {
        const x = el.getAttribute("data-bg-x") || 0;
        const y = el.getAttribute("data-bg-y") || 0;
        el.style.backgroundPosition = `${x}px ${y}px`;
    });
});