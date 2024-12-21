<template>

  <Sheet>
    <SheetTrigger>
      <Button variant="outline">
        Create Squad
      </Button>
    </SheetTrigger>
    <SheetContent>
      <SheetHeader>
        <SheetTitle>Create a Squad</SheetTitle>
      </SheetHeader>
      <form class="pt-4" @submit="onSubmit">
        <FormField v-slot="{ componentField }" name="name">
          <FormItem>
            <FormLabel>Name</FormLabel>
            <FormControl>
              <Input type="text" placeholder="Name" v-bind="componentField" />
            </FormControl>
          </FormItem>
          <FormMessage />
        </FormField>
        <SheetFooter class="pt-4 gap-4">
          <SheetClose>
            <Button type="submit" :loading="isSubmitting">
              Confirm
            </Button>
          </SheetClose>
          <SheetClose>
            <Button type="button" variant="destructive" :disabled="isSubmitting">
              Cancel
            </Button>
          </SheetClose>

        </SheetFooter>
      </form>
    </SheetContent>
  </Sheet>
</template>

<script setup lang="ts">
const props = defineProps<{
  onSubmit: VoidFunction
}>()
import { FormField } from '@/components/ui/form';
import Input from '@/components/ui/input/Input.vue';
import FormControl from '@/components/ui/form/FormControl.vue';
import FormItem from '@/components/ui/form/FormItem.vue';
import FormLabel from '@/components/ui/form/FormLabel.vue';
import { useApi, useNotice } from '@/ui/hooks';
import { toTypedSchema } from '@vee-validate/zod';
import { useForm } from 'vee-validate';
import { z } from 'zod';
import FormMessage from '@/components/ui/form/FormMessage.vue';
import Sheet from '@/components/ui/sheet/Sheet.vue';
import SheetTrigger from '@/components/ui/sheet/SheetTrigger.vue';
import SheetContent from '@/components/ui/sheet/SheetContent.vue';
import SheetHeader from '@/components/ui/sheet/SheetHeader.vue';
import SheetTitle from '@/components/ui/sheet/SheetTitle.vue';
import SheetFooter from '@/components/ui/sheet/SheetFooter.vue';
import SheetClose from '@/components/ui/sheet/SheetClose.vue';
import Button from '@/components/ui/button/Button.vue';
const { showSuccess, showError } = useNotice()
const { squadService } = useApi()
const formSchema = toTypedSchema(z.object({
  name: z.string().min(1)
}))

const { handleSubmit, isSubmitting } = useForm({
  validationSchema: formSchema
})
const onSubmit = handleSubmit(async (values) => {
  const response = await squadService.register(values.name)
  if (response.isFailure) {
    showError(response.errorMessage)
  }
  if (response.isSuccess) {
    showSuccess("Registered with sucess")
    props.onSubmit()
  }

})
</script>
