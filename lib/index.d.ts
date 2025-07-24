export interface AudioModule {
    playBackground(name: string, loop?: boolean, volume?: number): Promise<void>;
    stopBackground(): Promise<void>;
    playEffect(name: string, volume?: number): Promise<void>;
}
export declare const Audio: AudioModule;
