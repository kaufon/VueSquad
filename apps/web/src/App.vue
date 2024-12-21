<script setup lang="ts">
import { Loader2 } from 'lucide-vue-next';
import Toaster from './components/ui/toast/Toaster.vue';
</script>

<template>
  <Suspense>
    <template #default>
      <div>
        <RouterView />
        <Toaster />
      </div>
    </template>
    <template #fallback>
      <Loader2 class="w-full h-screen justify-center items-center animate-spin" />
    </template>
  </Suspense>
</template>
