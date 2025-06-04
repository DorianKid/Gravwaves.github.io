<script>
    document.addEventListener('DOMContentLoaded', function() {
        const mobileToggle = document.querySelector('.mobile-toggle');
        const navBlockGroup = document.querySelector('.nav-block-group');
        const navOverlay = document.querySelector('.nav-overlay');
        
        if (mobileToggle && navBlockGroup) {
            mobileToggle.addEventListener('click', function() {
                navBlockGroup.classList.toggle('open');
                navOverlay.classList.toggle('active');
            });
            
            // Cerrar menú al hacer clic en el overlay
            navOverlay.addEventListener('click', function() {
                navBlockGroup.classList.remove('open');
                navOverlay.classList.remove('active');
            });
            
            // Cerrar menú al hacer clic en un enlace (móvil)
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
</script>