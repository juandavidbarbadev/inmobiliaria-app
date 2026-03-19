// InmobiliariaApp — main.js

// Navbar scroll effect
window.addEventListener('scroll', () => {
    const navbar = document.getElementById('mainNavbar');
    if (navbar) {
        navbar.classList.toggle('shadow-lg', window.scrollY > 50);
    }
});

// Auto-hide alerts after 4 seconds
document.querySelectorAll('.alert-auto').forEach(alert => {
    setTimeout(() => {
        alert.style.transition = 'opacity .5s';
        alert.style.opacity = '0';
        setTimeout(() => alert.remove(), 500);
    }, 4000);
});

// Format price input with thousand separators
document.querySelectorAll('.price-input').forEach(input => {
    input.addEventListener('input', e => {
        let v = e.target.value.replace(/\D/g, '');
        e.target.value = v ? parseInt(v).toLocaleString('es-CO') : '';
    });
});
