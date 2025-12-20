
document.addEventListener('DOMContentLoaded', function() {
    const tabCategories = document.querySelector('.tab-categories');
    const footer = document.querySelector('.page-footer'); // Ajusta este selector a tu footer

    if (!tabCategories || !footer) return;

    // Guardar las dimensiones originales
    const originalOffsetTop = tabCategories.offsetTop;
    const originalWidth = tabCategories.offsetWidth;
    const originalHeight = tabCategories.offsetHeight;

    // Crear un elemento placeholder para mantener el espacio
    const placeholder = document.createElement('div');
    placeholder.style.width = originalWidth + 'px';
    placeholder.style.height = originalHeight + 'px';
    placeholder.style.display = 'none'; // Inicialmente oculto

    // Insertar el placeholder justo después de las categorías
    tabCategories.parentNode.insertBefore(placeholder, tabCategories.nextSibling);

    // Altura del menú superior - AJUSTA ESTE VALOR
    const menuHeight = 80; // Cambia este valor a la altura real de tu menú

    // Función que se ejecuta durante el scroll
    function handleScroll() {
        const scrollY = window.scrollY;
        const safeSpace = 20; // Espacio adicional
        const viewportHeight = window.innerHeight;
        
        // Calcular la posición del inicio del footer desde la parte superior
        const footerRect = footer.getBoundingClientRect();
        const footerTop = scrollY + footerRect.top; // Posición absoluta del footer
        
        // Altura total del elemento tabCategories
        const tabCategoriesHeight = tabCategories.offsetHeight;
        
        // Si se ha desplazado más allá de la posición original
        if (scrollY + 2> originalOffsetTop - menuHeight - safeSpace) {
        // Comprobar si el elemento llegaría a tocar el footer
        const wouldOverlapFooter = (scrollY + menuHeight + tabCategoriesHeight + 48) > footerTop - 40;
        
        if (wouldOverlapFooter) {
            // Posicionar justo encima del footer
            tabCategories.style.position = 'absolute';
            tabCategories.style.top = (footerTop - tabCategoriesHeight - (3.5*safeSpace) ) + 'px';
            tabCategories.style.width = originalWidth + 'px';
        } else {
            // Posición fija normal
            tabCategories.style.position = 'fixed';
            tabCategories.style.top = (menuHeight + safeSpace) + 'px';
            tabCategories.style.width = originalWidth + 'px';
        }
        
        // Mostrar el placeholder para mantener el espacio original
        placeholder.style.display = 'block';
        } else {
        // Devolver a la posición original
        tabCategories.style.position = 'static';
        tabCategories.style.width = 'auto';
        
        // Ocultar el placeholder cuando no es necesario
        placeholder.style.display = 'none';
        }
    }

    // Actualizar dimensiones del placeholder si cambia el tamaño de ventana
    function updateDimensions() {
        if (tabCategories.style.position !== 'fixed') {
        const newWidth = tabCategories.offsetWidth;
        const newHeight = tabCategories.offsetHeight;
        
        placeholder.style.width = newWidth + 'px';
        placeholder.style.height = newHeight + 'px';
        }
    }

    // Agregar los eventos
    window.addEventListener('scroll', handleScroll);
    window.addEventListener('resize', function() {
        updateDimensions();
        handleScroll();
    });

    // Ejecutar una vez al iniciar para configurar correctamente
    handleScroll();
    });

    function showVerticalTab(event, tabId) {
        // Identificar el tab principal activo
        const activeMainTab = document.querySelector('.tab-content.active');
        
        // Solo operar dentro del tab principal activo
        if (activeMainTab) {
            // Quitar active solo de los elementos dentro del tab principal activo
            activeMainTab.querySelectorAll('.tab-item-category').forEach(tab => 
                tab.classList.remove('active')
            );
            activeMainTab.querySelectorAll('.tab-content-video').forEach(content => 
                content.classList.remove('active')
            );

            // Añadir active al elemento clickeado
            event.currentTarget.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        }
    }
