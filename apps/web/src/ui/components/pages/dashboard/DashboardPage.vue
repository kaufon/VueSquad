<template>
  ola
</template>
<script setup lang="ts">
import { useApi } from '@/ui/hooks';

const { dashboardService } = useApi()
const response = await dashboardService.getUser()
console.log(response)
</script>
