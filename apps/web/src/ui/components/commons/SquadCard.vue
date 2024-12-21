<template>
  <Card class="h-72 w-72 ">
    <CardHeader class="flex flex-row justify-between w-full ">
      <CardTitle class="font-bold">{{ squad.name }}</CardTitle>
      <CardTitle>
        <RouterLink :to="`/squads/${squad.id}`">
          <ExternalLink />
        </RouterLink>
      </CardTitle>
    </CardHeader>
    <CardContent>
      <div class="flex flex-row  items-center justify-start">
        <div v-for="(user, index) in squad.users" class="border-b-gray border-b w-full font-light ">
          <div v-if="index < 4">
            {{ user.name }}
          </div>
          <div v-if="index == 5">
            ....
          </div>
        </div>
      </div>
    </CardContent>
  </Card>
</template>
<script setup lang="ts">
import { ExternalLink } from 'lucide-vue-next';
defineProps<{
  squad: SquadDto
}>()
import type { SquadDto } from '@/@core';
import { CardHeader, Card, CardTitle } from '@/components/ui/card';
import CardContent from '@/components/ui/card/CardContent.vue';

</script>
