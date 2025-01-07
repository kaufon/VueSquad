<template>
  <div class="w-full h-full p-4 flex items-center justify-between">
    <RegisterSquadForm :onSubmit="fetchSquads" />
    <div>
      <LogoutButton />
    </div>
  </div>
  <div class=" m-4 flex justify-center items-center">
    <Tabs default-value="squads" class="w-full h-screen">
      <TabsList class="w-full bg-transparent border-b border-l border-b-gray border-l-gray p-4">
        <TabsTrigger value="squads">Squads</TabsTrigger>
        <TabsTrigger value="tasks">Tasks</TabsTrigger>
      </TabsList>
      <TabsContent value="squads" class="pt-8">
        <SquadsTab :squads="squads" />
      </TabsContent>
      <TabsContent value="tasks">
        Tasks
      </TabsContent>
    </Tabs>
  </div>
</template>
<script setup lang="ts">
import Tabs from '@/components/ui/tabs/Tabs.vue';
import TabsContent from '@/components/ui/tabs/TabsContent.vue';
import TabsList from '@/components/ui/tabs/TabsList.vue';
import TabsTrigger from '@/components/ui/tabs/TabsTrigger.vue';
import SquadsTab from './squads-tab/SquadsTab.vue';
import { useApi, useNotice } from '@/ui/hooks';
import LogoutButton from './logout-button/LogoutButton.vue';
import RegisterSquadForm from './register-squad-form/RegisterSquadForm.vue';
import { ref } from 'vue';
import type { SquadDto } from '@/@core';
const { dashboardService } = useApi()
const { showError } = useNotice()
const squads = ref<SquadDto[]>([]);
const fetchSquads = async () => {
  const response = await dashboardService.getSquads();
  if (response.isFailure) {
    showError(response.errorMessage);
  } else {
    squads.value = response.body;
  }
}
fetchSquads()

</script>
