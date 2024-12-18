export type TaskDto = {
	id?: string;
	squad_id: string;
	creator_id: string;
	deadline?: Date;
	name: string;
	size?: "XS" | "S" | "M" | "L" | "XL";
	status: "todo" | "inProgress" | "done";
	description?: string;
	created_at: Date;
	updated_at: Date;
	priority?: "LOW" | "MEDIUM" | "HIGH";
	users: Array<{ id: string; name: string }>;
};
