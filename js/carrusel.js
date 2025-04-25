document.addEventListener('DOMContentLoaded', function() {
    // Configuración del carrusel
    const track = document.querySelector('.carousel-track');
    const slides = Array.from(track.children);
    const nextButton = document.querySelector('#next');
    const prevButton = document.querySelector('#prev');
    const indicators = document.querySelectorAll('.carousel-indicator');
    
    // Intervalo de tiempo para cambio automático (5 segundos = 5000ms)
    const autoplayInterval = 5000;
    let currentIndex = 0;
    let autoplayTimer = null;
    let isAutoplayPaused = false;

    // Función para actualizar el carrusel
    function updateCarousel(index) {
        track.style.transform = `translateX(-${index * 100}%)`;
        indicators.forEach((indicator, i) => {
            indicator.classList.toggle('active', i === index);
        });
    }

    // Función para avanzar al siguiente slide
    function nextSlide() {
        currentIndex = (currentIndex + 1) % slides.length;
        updateCarousel(currentIndex);
    }

    // Función para retroceder al slide anterior
    function prevSlide() {
        currentIndex = (currentIndex - 1 + slides.length) % slides.length;
        updateCarousel(currentIndex);
    }

    // Iniciar autoplay
    function startAutoplay() {
        if (autoplayTimer === null) {
            autoplayTimer = setInterval(nextSlide, autoplayInterval);
        }
    }

    // Pausar autoplay
    function pauseAutoplay() {
        if (autoplayTimer !== null) {
            clearInterval(autoplayTimer);
            autoplayTimer = null;
        }
    }

    // Reiniciar el timer de autoplay cuando el usuario interactúa
    function resetAutoplayTimer() {
        if (!isAutoplayPaused) {
            pauseAutoplay();
            startAutoplay();
        }
    }

    // Event listeners para botones de navegación
    nextButton.addEventListener('click', () => {
        nextSlide();
        resetAutoplayTimer();
    });

    prevButton.addEventListener('click', () => {
        prevSlide();
        resetAutoplayTimer();
    });

    // Event listeners para indicadores
    indicators.forEach((indicator, i) => {
        indicator.addEventListener('click', () => {
            currentIndex = i;
            updateCarousel(currentIndex);
            resetAutoplayTimer();
        });
    });

    // Pausar autoplay cuando el mouse está sobre el carrusel
    const carousel = document.querySelector('.carousel');
    carousel.addEventListener('mouseenter', () => {
        isAutoplayPaused = true;
        pauseAutoplay();
    });

    // Reanudar autoplay cuando el mouse sale del carrusel
    carousel.addEventListener('mouseleave', () => {
        isAutoplayPaused = false;
        startAutoplay();
    });

    // Iniciar autoplay al cargar la página
    startAutoplay();

    // Gestión de videos
    const videos = document.querySelectorAll('.carousel-slide video');
    const carouselSlides = document.querySelectorAll('.carousel-slide');
    const carouselButtons = document.querySelectorAll('.carousel-button');
    const infoOverlays = document.querySelectorAll('.info-overlay');
    
    // Función para colapsar todos los videos
    function collapseAllVideos() {
        document.querySelectorAll('.video-container.expanded').forEach(container => {
            container.classList.remove('expanded');
            // Importante: También removemos los controles del video al colapsar
            const video = container.querySelector('video');
            if (video && video.hasAttribute('controls')) {
                video.removeAttribute('controls');
                // Opcional: pausar el video cuando se colapsa
                video.pause();
            }
        });
    }
    
    // Envolver cada video en un contenedor si aún no lo está
    videos.forEach(video => {
        if (!video.parentElement.classList.contains('video-container')) {
            const container = document.createElement('div');
            container.className = 'video-container';
            video.parentNode.insertBefore(container, video);
            container.appendChild(video);
        }
        
        // Agregar event listener para expandir/contraer al hacer clic
        video.addEventListener('click', function(e) {
            // Pausar autoplay cuando se expande un video
            pauseAutoplay();
            isAutoplayPaused = true;
            
            // Alternar controles
            if (!this.hasAttribute('controls')) {
                this.setAttribute('controls', '');
            }
            
            // Alternar clase 'expanded' en el contenedor
            this.parentElement.classList.toggle('expanded');
            
            // Si estamos colapsando, también quitar los controles
            if (!this.parentElement.classList.contains('expanded')) {
                this.removeAttribute('controls');
                this.pause();
                // Reanudar autoplay
                isAutoplayPaused = false;
                startAutoplay();
            } else {
                // Si estamos expandiendo, intentar reproducir
                if (this.paused) {
                    this.play().catch(err => console.log('Error al reproducir:', err));
                }
            }
            
            // Evitar que el clic se propague al carrusel
            e.stopPropagation();
        });
    });
    
    // Modificado: Ahora los clics en info-overlay colapsan los videos
    // Pero seguimos evitando la propagación de clics en enlaces
    infoOverlays.forEach(overlay => {
        overlay.addEventListener('click', function(e) {
            // Si el clic es en un enlace, permitir la acción predeterminada
            if (e.target.tagName.toLowerCase() === 'a') {
                // Solo para enlaces, evitamos la propagación para que funcionen normalmente
                e.stopPropagation();
            } else {
                // Para cualquier otro elemento en el overlay, colapsamos los videos
                collapseAllVideos();
                // Reanudar autoplay después de colapsar
                isAutoplayPaused = false;
                startAutoplay();
            }
        });
    });
    
    // Agregar event listener para colapsar videos al hacer clic en el slide
    carouselSlides.forEach(slide => {
        slide.addEventListener('click', function(e) {
            // Solo colapsar si el clic fue directamente en el slide
            // y no en un video o en un enlace dentro del overlay
            if (e.target === this || !e.target.closest('.video-container')) {
                collapseAllVideos();
                // Reanudar autoplay después de colapsar
                isAutoplayPaused = false;
                startAutoplay();
            }
        });
    });
    
    // Colapsar videos al hacer clic en botones de navegación
    carouselButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            collapseAllVideos();
            // Reanudar autoplay después de navegar
            isAutoplayPaused = false;
            startAutoplay();
            // Evitar que el clic se propague al documento
            e.stopPropagation();
        });
    });
    
    // Colapsar videos al hacer clic en los indicadores
    document.querySelectorAll('.carousel-indicator').forEach(indicator => {
        indicator.addEventListener('click', function(e) {
            collapseAllVideos();
            // Reanudar autoplay después de navegar
            isAutoplayPaused = false;
            startAutoplay();
            // Evitar que el clic se propague al documento
            e.stopPropagation();
        });
    });
    
    // Agregar listener para colapsar videos al hacer clic en cualquier parte fuera del carrusel
    document.addEventListener('click', function(e) {
        // Verificar si el clic no fue dentro de un video, sus controles, un botón del carrusel o un overlay
        if (!e.target.closest('.carousel')) {
            collapseAllVideos();
            // Reanudar autoplay
            isAutoplayPaused = false;
            startAutoplay();
        }
    });
});