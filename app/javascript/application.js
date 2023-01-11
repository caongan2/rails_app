// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

$(function () {
    let flag = false
    $('#dropdownMenuLink').on('click', function () {
        flag = !flag
        if (flag === true) {
            $('.dropdown-menu').css('display', 'block')
        } else {
            $('.dropdown-menu').css('display', 'none')
        }
    })
})