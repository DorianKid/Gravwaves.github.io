// SCRIPT PARA EL MENÚ MÓVIL 
document.addEventListener('DOMContentLoaded', function() {
    const mobileToggle = document.querySelector('.mobile-toggle');
    const navBlockGroup = document.querySelector('.nav-block-group');
    const navOverlay = document.querySelector('.nav-overlay');
    
    if (mobileToggle && navBlockGroup) {
        // TOGGLE DEL MENÚ MÓVIL
        mobileToggle.addEventListener('click', function() {
            navBlockGroup.classList.toggle('open');
            navOverlay.classList.toggle('active');
        });
        
        // CERRAR MENÚ AL HACER CLIC EN EL OVERLAY
        navOverlay.addEventListener('click', function() {
            navBlockGroup.classList.remove('open');
            navOverlay.classList.remove('active');
        });
        
        // CERRAR MENÚ AL HACER CLIC EN UN ENLACE (SOLO EN MÓVIL)
        const menuLinks = document.querySelectorAll('.menu a');
        menuLinks.forEach(link => {
            link.addEventListener('click', function() {
                if (window.innerWidth <= 768) {
                    navBlockGroup.classList.remove('open');
                    navOverlay.classList.remove('active');
                }
            });
        });
    }
});

