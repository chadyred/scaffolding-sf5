<template>
    <div class="hello">
        <h1 class="hello--title__bgc hello--title__color">{{ msg }}</h1>
    </div>
</template>

<style lang="scss">

    @import "./../scss/_variables.scss";

    .hello {
        &--title {
            &__bgc {
                background-color: $main-site-color-red;
            }
            &__color {
                color: $main-site-color-green;
            }
        }
    }
</style>

<script>

    class TestComponentHello {

    }

    export default {
        name: 'hello',
        data () {
            return {
                msg: 'Welcome to Your Vue.js App'
            }
        }
    }
</script>