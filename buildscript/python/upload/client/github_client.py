from . import LazyFileReader
from .github_model import *
from dataclasses import asdict
from tqdm import tqdm
import os, dacite, requests



class GithubFileTransferClient:
	def __init__(self, api_key):
		self.session = requests.Session()
		self.api_key = api_key

	def upload_file(self, request: CreateDraftReleaseResponse, file_path: str, expected_name):
		print(f"Uploading File {file_path} as {expected_name}")

		url = request.upload_url.split("{")[0]

		file_size = os.path.getsize(file_path)

		with open(file_path, 'rb') as f, tqdm(
				total=file_size, unit="B", unit_scale=True, unit_divisor=1024, desc=""
		) as pbar:
			stream = LazyFileReader(f, pbar, file_size)
			response = self.session.post(
				url=f"{url}?name={expected_name}",
				data=stream,
				headers={
					"Authorization": f"Bearer {self.api_key}",
					"Accept": "application/vnd.github+json",
					"X-GitHub-Api-Version": "2026-03-10",
					'Content-Length': str(file_size),
					'Content-Type': 'application/octet-stream'
				}
			)
			response.raise_for_status()

class GithubClient:
	def __init__(self, api_key, owner, repo):
		self.config = dacite.Config(type_hooks={
			datetime: datetime.fromisoformat
		})
		self.base_url = "https://api.github.com"
		self.owner = owner
		self.repo = repo
		self.headers = {
			"Authorization": f"Bearer {api_key}",
			"Accept": "application/vnd.github+json",
			"Content-Type": "application/json",
			"X-GitHub-Api-Version": "2026-03-10"
		}


	def create_draft(self, request: CreateDraftReleaseRequest) -> CreateDraftReleaseResponse:
		response = requests.post(f"{self.base_url}/repos/{self.owner}/{self.repo}/releases", headers=self.headers, json=asdict(request))
		if response.status_code == 201:
			return dacite.from_dict(data_class=CreateDraftReleaseResponse, data=response.json(), config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)



	#
	# def get_mod(self) -> ModInfo:
	# 	response = requests.get(f"{self.base_url}/games/{self.game}/mods/{self.mod_id}", headers=self.headers)
	# 	if response.status_code == 200:
	# 		return dacite.from_dict(data_class=ModInfo, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def get_upload_groups(self, mod: ModInfo) -> FileUpdateGroups:
	# 	response = requests.get(f"{self.base_url}/mods/{mod.id}/file-update-groups", headers=self.headers)
	# 	if response.status_code == 200:
	# 		return dacite.from_dict(data_class=FileUpdateGroups, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def get_upload_state(self, upload: SingleUploadResponse | MultipartUploadResponse) -> UploadState:
	# 	response = requests.get(f"{self.base_url}/uploads/{upload.id}", headers=self.headers)
	# 	if response.status_code == 200:
	# 		return dacite.from_dict(data_class=UploadState, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def create_upload(self, request: UploadRequest) -> SingleUploadResponse:
	# 	response = requests.post(f"{self.base_url}/uploads", headers=self.headers, json=asdict(request))
	# 	if response.status_code == 201:
	# 		return dacite.from_dict(data_class=SingleUploadResponse, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def create_upload_multipart(self, request: UploadRequest) -> MultipartUploadResponse:
	# 	response = requests.post(f"{self.base_url}/uploads/multipart", headers=self.headers, json=asdict(request))
	# 	if response.status_code == 201:
	# 		return dacite.from_dict(data_class=MultipartUploadResponse, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def finalize_upload(self, state: UploadState) -> UploadState:
	# 	response = requests.post(f"{self.base_url}/uploads/{state.id}/finalise", headers=self.headers)
	# 	if response.status_code == 200:
	# 		return dacite.from_dict(data_class=UploadState, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def create_new_file(self, request: CreateNewFileRequest) -> NewFileResponse:
	# 	response = requests.post(f"{self.base_url}/mod-files", headers=self.headers, json=asdict(request))
	# 	if response.status_code == 201:
	# 		return dacite.from_dict(data_class=NewFileResponse, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
	#
	# def update_file(self, request: UpdateFileRequest, group_id: str) -> NewFileResponse:
	# 	response = requests.post(f"{self.base_url}/mod-file-update-groups/{group_id}/versions", headers=self.headers, json=asdict(request))
	# 	if response.status_code == 201:
	# 		return dacite.from_dict(data_class=NewFileResponse, data=response.json()['data'], config=self.config)
	# 	else:
	# 		raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
