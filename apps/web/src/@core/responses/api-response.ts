import { HTTP_STATUS_CODE } from "../constants";
import { AppError } from "../errors";

type ApiResponseProps<Body> = {
	body?: Body;
	statusCode?: number;
	errorMessage?: string;
};

export class ApiResponse<Body = void> {
	private readonly _body: Body | null;
	private readonly _statusCode: number;
	private readonly _errorMessage: string | null;

	constructor({ body, statusCode, errorMessage }: ApiResponseProps<Body>) {
		this._body = body ?? null;
		this._statusCode = statusCode ?? 200;
		this._errorMessage = errorMessage ?? null;
	}
	get isSuccess() {
		return this.statusCode <= HTTP_STATUS_CODE.badRequest;
	}

	get isFailure() {
		return this.statusCode >= HTTP_STATUS_CODE.badRequest;
	}

	get body(): Body {
		if (this._body === null) {
			throw new AppError("Api response error", "Response is an error");
		}

		return this._body;
	}

	get statusCode(): number {
		return this._statusCode;
	}

	get errorMessage(): string {
		if (!this._errorMessage) {
			throw new AppError("Api response error", "Response is not an error");
		}
		if (
			this._body &&
			typeof this._body === "object" &&
			!Array.isArray(this._body)
		) {
			const errorEntries = Object.entries(this._body);
			if (errorEntries.length > 0) {
				const firstErrorKey = errorEntries[0][0];
				const firstErrorMessage = errorEntries[0][1][0];
				return `${firstErrorKey.charAt(0).toUpperCase() + firstErrorKey.slice(1)} ${firstErrorMessage}`;
			}
		}
		return this._errorMessage;
	}
}
