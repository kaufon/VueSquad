<template>
  <div>
    <LogOutIcon class="size-8 text-white" v-on:click="logout" />
  </div>
</template>
<script setup lang="ts">
import router from '@/app/router';
import { LogOutIcon } from 'lucide-vue-next';
function logout() {

  localStorage.removeItem("jwt")
  router.push("/login")
}
</script>
