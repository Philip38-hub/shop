// Product card animations and interactions
document.addEventListener('turbolinks:load', () => {
  // Initialize all product cards
  initProductCards();
  
  // Handle add to cart animations
  setupAddToCartButtons();
});

function initProductCards() {
  // Add animation class to newly loaded cards
  const productCards = document.querySelectorAll('.product-card');
  productCards.forEach((card, index) => {
    setTimeout(() => {
      card.classList.add('new-item');
    }, index * 100); // Stagger the animations
  });
  
  // Handle hover effects for touch devices
  if ('ontouchstart' in window) {
    productCards.forEach(card => {
      card.addEventListener('touchstart', function() {
        this.classList.add('is-touched');
      });
      
      document.addEventListener('touchstart', function(e) {
        if (!card.contains(e.target)) {
          card.classList.remove('is-touched');
        }
      });
    });
  }
}

function setupAddToCartButtons() {
  const addToCartButtons = document.querySelectorAll('.add-to-cart');
  
  addToCartButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      // Don't prevent default as we want the form to submit
      
      // Add visual feedback
      const originalText = this.innerHTML;
      this.classList.add('is-loading');
      
      setTimeout(() => {
        this.classList.remove('is-loading');
        this.innerHTML = '<span class="icon"><i class="fa fa-check"></i></span><span>Added!</span>';
        
        setTimeout(() => {
          this.innerHTML = originalText;
        }, 2000);
      }, 600);
    });
  });
}

// Make sure this script is included in your application.js or as a separate pack