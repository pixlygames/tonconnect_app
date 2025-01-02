// Hide the UI at the beginning
$(document).ready(function () {
    $('.OurDiv').hide();
});

window.addEventListener('message', function(event) {
    var item = event.data;

    if (item.showUI) {
        $('.OurDiv').show();
        // Enable NuiFocus when UI is shown
        fetch(`https://${GetParentResourceName()}/enableNuiFocus`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ enable: true })
        });
    } else {
        $('.OurDiv').hide();
        // Disable NuiFocus when UI is hidden
        fetch(`https://${GetParentResourceName()}/enableNuiFocus`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ enable: false })
        });
    }
});

// Handle ESC key press to disable NuiFocus
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        $('.OurDiv').hide();
        fetch(`https://${GetParentResourceName()}/enableNuiFocus`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ enable: false })
        });
    }
});
