var app = new Vue({
    el: '#vehicleShop',
    data: {
        selectedCategory: "loading",
        selectedVehicle: "",
        currentVehicles: [],
        currentListLocation: 0,
        categories: {
            1: { name: "loading", label: "Loading.." }
        },
        vehicles: {
            // 1: { name: "Volkswagon Caddy", price: "100000", trunksize: "10000", category: "ltdedition", imglink: "https://i.imgur.com/3iFlPpR.png", loaded: false },
        }
    },
    methods: {
        switchCategory: function (category) {
            this.selectedCategory = category;
            this.currentListLocation = 0;
            this.currentVehicles = this.getVehiclesInCategory(this.selectedCategory, 0);
        },
        nextPage: function () {
            if (this.nextPageAvailable) {
                this.currentListLocation += 6;
                this.currentVehicles = this.getVehiclesInCategory(this.selectedCategory, this.currentListLocation);
            }
        },
        prevPage: function () {
            if (this.prevPageAvailable) {
                this.currentListLocation -= 6;
                this.currentVehicles = this.getVehiclesInCategory(this.selectedCategory, this.currentListLocation);
            }
        },
        getVehiclesInCategory: function (category, startAt) {
            let selectedVehicles = [];
            for (vehicle in this.vehicles) {
                let thisVehicle = this.vehicles[vehicle];
                if (thisVehicle.category.toLowerCase() == category.toLowerCase()) {
                    selectedVehicles.push(thisVehicle);
                }
            }

            return selectedVehicles.slice(startAt, startAt + 6);
        },
        getTotalVehiclesInCategory: function (category) {
            let count = 0;
            for (vehicle in this.vehicles) {
                let thisVehicle = this.vehicles[vehicle];
                if (thisVehicle.category.toLowerCase() == category.toLowerCase()) {
                    count++;
                }
            }

            return count;
        },
        purchaseVehicle: function (vehicle) {
            $.post('http://otaku_vehicleshop/BuyVehicle', JSON.stringify({ vehicle: vehicle }));
            CloseShop();
        }
    },
    computed: {
        nextPageAvailable: function () {
            return this.getTotalVehiclesInCategory(this.selectedCategory) - 6 > this.currentListLocation;
        },

        prevPageAvailable: function () {
            return this.currentListLocation >= 6;
        }
    },
    filters: {
        formatMoney: function (val) {
            return Number(val).toLocaleString('en-GB');
        }
    },
    created: function () {
        this.currentVehicles = this.getVehiclesInCategory(this.selectedCategory, 0);
    }
});

function CloseShop() {
    $("#shopmenu").hide();
    $.post('http://otaku_vehicleshop/CloseMenu', JSON.stringify({}));
}

$(document).keyup(function (e) {
    if (e.key === "Escape") {
        CloseShop()
    }
});

$(document).ready(function () {
    $("#close").click(function () {
        CloseShop()
    });

    window.addEventListener('message', function (event) {
        var data = event.data;
        app.categories = data.categories;
        app.vehicles = data.cars;
        app.selectedCategory = data.selectedCategory;

        if (data.show) {
            $("#shopmenu").show();
            app.switchCategory(app.selectedCategory)
        }
    });
});
