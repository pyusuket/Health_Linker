/* global fetch */
  document.addEventListener('DOMContentLoaded', () => {
    const searchButton = document.getElementById('search_button');
    searchButton.addEventListener('click', () => {
      const postalCodeField = document.getElementById('postal_code_field').value;
      fetch(`https://api.zipaddress.net/?zipcode=${postalCodeField}`, {
      })
      .then(response => {
        return response.json();
      })
      .then(rc => {
        document.getElementById('prefecture_field').value = rc.data.pref;
        document.getElementById('city_field').value = rc.data.city;
      })
      .catch(error => {
        console.error('Error:', error)
      });
    });
  });