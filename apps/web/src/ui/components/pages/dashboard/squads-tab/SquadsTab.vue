<template>
  <div class="grid md:grid-cols-5 grid-row-5 gap-2  md:gap-24">
    <div v-for="squad in squads" class="col-span-1" :key="squad.id">
      <SquadCard :squad="squad" />
    </div>
  </div>
</template>
<script setup lang="ts">
defineProps<{
  squads: SquadDto[]
}>()
import SquadCard from '@/ui/components/commons/SquadCard.vue';
import type { SquadDto } from '@/@core';

</script>
