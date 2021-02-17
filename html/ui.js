var app = new Vue({
    el: '#vehicleShop',
    data: {
        selectedCategory: "ltdedition",
        selectedVehicle: "",
        currentVehicles: [],
        currentListLocation: 0,
        categories: {
            1: { name: "ltdedition", label: "Limited Edition" },
            2: { name: "test1", label: "test1" },
            3: { name: "test2", label: "test2" },
            4: { name: "test4", label: "test4" },
            5: { name: "test5", label: "test5" }
        },
        vehicles: {
            1: { name: "Volkswagon Caddy", price: "100000", trunksize: "10000", category: "ltdedition", imglink: "https://i.imgur.com/3iFlPpR.png", loaded: false },
            2: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/b/b9/Dilettante.png/164px-Dilettante.png", loaded: false },
            3: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://vignette.wikia.nocookie.net/gtawiki/images/b/be/190z-GTAO-front.png/revision/latest/scale-to-width-down/164?cb=20171218203545", loaded: false },
            4: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://img.gta5-mods.com/q95/images/2016-mclaren-675lt-coupe-zen-imogen-zenzoit-ngr_ardiansyah/c35070-Screenshot%20(697).jpg", loaded: false },
            5: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/4/4d/Oracle2.png/164px-Oracle2.png", loaded: false },
            6: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/6/6e/Superd.png/164px-Superd.png", loaded: false },
            7: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/2/2d/Windsor.png/164px-Windsor.png", loaded: false },
            8: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test2", imglink: "https://img.gta5-mods.com/q85-w800/images/2018-lamborghini-aventador-s-roadster-add-on/2dd379-Grand%20Theft%20Auto%20V%202018_3_8%2015_21_12_%E7%9C%8B%E5%9B%BE%E7%8E%8B.jpg", loaded: false },
            9: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test1", imglink: "http://www.gta5rides.com/vehicleImages/cropped/autarch.jpg.jpg", loaded: false },
            10: { name: "McLaren 675LT", price: "100000", trunksize: "10000", category: "test1", imglink: "http://www.gta5rides.com/vehicleImages/cropped/autarch.jpg.jpg", loaded: false },
            11: { name: "Buccaneer", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/d/de/Buccaneer.png/164px-Buccaneer.png", loaded: false },
            12: { name: "Buccaneer", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/d/de/Buccaneer.png/164px-Buccaneer.png", loaded: false },
            13: { name: "Buccaneer", price: "100000", trunksize: "10000", category: "test2", imglink: "https://wiki.rage.mp/images/thumb/d/de/Buccaneer.png/164px-Buccaneer.png", loaded: false }
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
    $("#wrapper").html('');
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
        app.selectedCategory = "ltdedition";

        if (data.show) {
            $("#shopmenu").show();
            app.currentVehicles = app.getVehiclesInCategory(app.selectedCategory, 0);
        }
    });
});
