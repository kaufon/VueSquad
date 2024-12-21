import { useToast } from "@/components/ui/toast";

export const useNotice = () => {
	const { toast } = useToast();

	const showSuccess = (message: string) => {
		toast({
			variant: "default",
			title: "Sucess",
			description: message,
		});
	};

	const showError = (message: string) => {
		toast({
			variant: "destructive",
			title: "Error",
			description: message,
		});
	};

	return { showSuccess, showError };
};
