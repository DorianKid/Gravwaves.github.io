document.addEventListener('DOMContentLoaded', function() {
    // Get all tab items
    const tabItems = document.querySelectorAll('.tab-item');
    
    // Add click event to each tab
    tabItems.forEach(function(tab) {
        tab.addEventListener('click', function() {
            // Get the data-tab attribute value (tab ID)
            const tabId = this.getAttribute('data-tab');
            
            // Remove active class from all tabs
            tabItems.forEach(function(item) {
                item.classList.remove('active');
            });
            
            // Remove active class from all tab contents
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(function(content) {
                content.classList.remove('active');
            });
            
            // Add active class to current tab
            this.classList.add('active');
            
            // Add active class to corresponding tab content
            document.getElementById(tabId).classList.add('active');
        });
    });
});
